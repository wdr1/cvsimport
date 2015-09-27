package IO::Resume;

## $Id: Resume.pm,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

use strict;
use warnings;

use Carp;
use Digest::MD5 qw|md5_hex|;
use IO::Handle;

use Data::Dumper;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use IO::Resume ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10); 

our $gConfig = {};

## Use to catch SIGINT
our $STAY_ALIVE = 1;

####################################################################  run  ###
## 
sub run {
  my (%raw_args) = @_;

  $gConfig = { %raw_args };
  ## Figure out options, config, etc
  &validate_and_expand_args( $gConfig );
  ## Setup 
  &prime_marker_info( $gConfig );
  ## Now that we're configured, open the various output files
  &open_file_handles( $gConfig );
  ## Catch ^c
  &install_sigint();
  say_debug( "run initialization complete" );

  foreach my $f (@{ $gConfig->{'input_file'} }) {
    &process_file( $gConfig, $f );
  }
  &close_file_handles( $gConfig );

  return 1;
}


######################################################  open_file_handles  ###
## Figure out what to open & how to open it (truncate vs. append)
sub open_file_handles {
  my ($conf) = @_;

  ## Various output files
  my @file_handle_mappings =
    (
     [ 'say_output_file', 'say_output_handle' ],
     [ 'say_status_file', 'say_status_handle' ],
     [ 'say_error_file', 'say_error_handle' ],
    );
  my $mode = '>';  ## For first run, truncate
  if (defined $conf->{'file_open_mode'}) { ## For 2nd+ run, append
    $mode = $conf->{'file_open_mode'};
  }
  say_debug("File mode: '$mode'");
  foreach my $pair (@file_handle_mappings) {
    my ($file, $handle)  = @$pair;
    say_debug( "Mapping '$file' to '",
               $conf->{$file}, "'" );

    unless ( $conf->{$file} eq '-' ) {
      $conf->{$handle} = undef;
      open($conf->{$handle}, $mode, $conf->{$file})
        || confess("Couldn't open ('$mode') '",
                   $gConfig->{$file}, "' ($file)': $!");
    }
  }
}


#####################################################  close_file_handles  ###
## 
sub close_file_handles {
  my ($conf) = @_;

  my @handles = qw| say_output_handle say_status_handle say_error_handle |;
  foreach my $h (@handles) {
    unless ( fileno( $conf->{$h} ) == fileno( STDERR )
             || fileno( $conf->{$h} ) == fileno( STDOUT ) ) {
      close( $conf->{$h} ) || warn($!);
    }
  }
}


#########################################################  install_sigint  ###
## 
sub install_sigint {
  $STAY_ALIVE = 1;

  $::SIG{INT} = sub { $STAY_ALIVE = 0; };
}


##################################################  do_i_process_this_row  ###
## 
sub do_i_process_this_row {
  my ($conf, $row) = @_;

  ## check if we skip it
  if ($conf->{'skip'}{$row}) {
    return 0;
  }

  ## process all rows?
  if ($conf->{'rows'}{'all'}) {
    return 1;
  }

  ## process all rows?
  if ($conf->{'rows'}{$row}) {
    return 1;
  } else {
    return 0;
  }
}


###########################################################  process_file  ###
## 
sub process_file {
  my ( $args, $file ) = @_;

  say_debug( "Processing file '$file'..." );
  my $time_counter = time + time % $args->{'status_second_count'};

  if( open(F, '<', $file) ) {
    &advance_filehandle(\*F, $args->{'row_start'});
    my $row_counter = $args->{'row_start'};
    say_status("Processing '$file' starting at row $row_counter...\n");
    
    while(<F>) {
      say_debug( "LINE: $_" );

      my $bProcessRow = &do_i_process_this_row( $gConfig, $row_counter );

      if ($bProcessRow) {
        ## Get results
        my $result = &{$args->{'function'}}( $_, $args, );

        ## TODO: default output 
        say_output( $result );
        
        ## Update the marker
        &update_marker($args, $row_counter);
      
        ## Report status?
        if ($args->{'status_row_count'}) {
          unless ( $row_counter % $args->{'status_row_count'}) {
            say_status("Processing row $row_counter...\n");
          }
        } else {
          unless ($time_counter % $args->{'status_second_count'}) {
            say_status("Processing row $row_counter...\n");
          }
        }
      }
      
      unless ($STAY_ALIVE) {
        say_status("Exiting early on row '$row_counter' due to SIGINT...");
        last;
      }
      
      $row_counter++;
    }
  } else {
    say_error("Couldn't process '$file': $!... Skipping!")
  }
  close(F) || warn($!);

  ## Remove the marker only if we terminated naturally (e.g., not ^c)
  &remove_markers( $args ) if ($STAY_ALIVE);
}


##############################################  find_starting_position  ###
## Find where we should start.  This may
## not be the start of the file due to a prior-run, the user
## indicating a different spot via the command-line, etc.
sub find_starting_position {
  my ($args) = @_;

  ## Defaults
  my $start = 1;
  my $why = 'start of file';

  ## Look for prior marker location
  my $marker = $args->{'marker_file'};
  if (-e $marker) {
    local *MARKER;
    open(MARKER, '<', $marker) || die("Marker '$marker' exists, but I couldn't read it?!");
    $start = <MARKER>;
    $why   = 'resuming from prior run';
  }

  ## Check for command-line arg
  if ($args->{'row_start'}) {
    $start = $args->{'row_start'};
    $why   = 'user specified';
  }

  say_status("Starting on row $start ($why)...");
  
  return $start;
}


#####################################################  advance_filehandle  ###
## 
sub advance_filehandle {
  my ($fh, $max) = @_;

  my $c = 1;
  while ($c++ < $max) {
    <$fh>;
  }
}


##########################################################  remove_markers  ###
## 
sub remove_markers {
  my ($args) = @_;

  my $marker = $gConfig->{'marker_handle'};
  if ($marker) {
    close($marker) || warn($!);
  } else {
    say_warning( "Not closing marker as it's undefined?" );
  }
  
  if ($marker) {
    say_debug( "Removing marker file...");
    unlink( $args->{'marker_file'} ) ||
    say_error("Couldn't remove '",
              $args->{'marker_file'}, "': $!.  You should manually remove",
              " this file." );
  }

  unlink ($args->{'run_file'}) ||
    say_error("Couldn't remove '",
              $args->{'run_file'}, "': $!.  You should manually remove",
              " this file." );


  $marker = undef;
}


######################################################  update_run_marker  ###
## 
sub update_run_marker {
  my ($args) = @_;
  
  my $run = 0;
  my $mfile = $args->{'run_file'};
  
  if (-f $mfile) {
    open(F, '<', $mfile) || croak("Trouble updating marker '$mfile': $!");
    $run = <F>;
    close(F) || warn($!);
  }

  $run++;
  open(F, '>', $mfile) || croak("Trouble updating marker '$mfile': $!");
  print F $run;
  close(F) || warn($!);

  return $run;
}


##########################################################  update_marker  ###
## 
sub update_marker {
  my ($conf, $c) = @_;

  my $marker = $conf->{'marker_handle'};
  unless ($marker) {
    say_debug( "Creating marker '", $conf->{'marker_file'}, "'...");
    open($marker, '>', $conf->{'marker_file'}) ||
      die("Couldn't open marker file '", $conf->{'marker_file'}, "'!");
    $conf->{'marker_handle'} = $marker;
  }

  seek($marker, 0, 0) ||
    warn("Trouble seeking in marker handle: $!");
  print $marker $c;
}


######################################################  prime_marker_info  ###
## 
sub prime_marker_info {
  my ($gConfig) = @_;

  ## Where do we start processing the file?
  $gConfig->{'row_start'} = &find_starting_position( $gConfig );

  ## What run is this?
  $gConfig->{'run_count'} = &update_run_marker( $gConfig );
  
  ## how to open files -- truncate or append
  if ($gConfig->{'row_start'} == 1) {
    $gConfig->{'file_open_mode'} = '>';
  } else {
    $gConfig->{'file_open_mode'} = '>>';
  }

}


###############################################  validate_and_expand_args  ###
## 
sub validate_and_expand_args {
  my ($gConfig) = @_;

  ###############################################
  ## Process required args
  ###############################################
  
  ## 'function' check
  unless ( defined $gConfig->{'function'}
           && ref $gConfig->{'function'} eq 'CODE' ) {
    confess("No function passed in or is not a function!");
  }

  ## check input files 
  unless ( defined $gConfig->{'input_file'} ) {
    confess("No input files given!");
  }
  unless (ref $gConfig->{'input_file'} ) {
    $gConfig->{'input_file'} = [ $gConfig->{'input_file'} ];
  }
  foreach my $f (@{ $gConfig->{'input_file'}}) {
    unless (-f $f) {
      die("Input file '$f' doesn't exist or isn't a file...\n");
    }
  }

  ## Opaque custom user-args
  unless (defined $gConfig->{'args'}) {
    $gConfig->{args} = {};
  }
  

  ###############################################
  ## Process optional args 
  ###############################################
  
  ## Spew status?
  $gConfig->{'say_status_enabled'} = 1;
  if (defined $gConfig->{'silent'}) {
    $gConfig->{'say_status_enabled'} = 0;
  }

  ## Spew debug?
  $gConfig->{'say_debug_enabled'}  = $ENV{'IORESUME_DEBUG'} || 0;
  if (defined $gConfig->{'say_debug_enabled'}) {
    $gConfig->{'say_debug_enabled'} = $gConfig->{'say_debug_enabled'};
  }

  ## File for program output (- == STDOUT)
  $gConfig->{'say_output_file'} = '-';
  if (defined $gConfig->{'output_file'}) {
    $gConfig->{'say_output_file'} = $gConfig->{'output_file'};
  }
  $gConfig->{'say_output_handle'} = \*STDOUT;
  
  ## File for status output (- == STDOUT)
  $gConfig->{'say_status_file'} = '-';
  if (defined $gConfig->{'status_file'}) {
    $gConfig->{'say_status_file'} = $gConfig->{'status_file'};
  }
  $gConfig->{'say_status_handle'} = \*STDOUT;
  
  ## File for error output (- == STDERR)
  $gConfig->{'say_error_file'} = '-';
  if (defined $gConfig->{'error_file'}) {
    $gConfig->{'say_error_file'} = $gConfig->{'error_file'};
  }
  $gConfig->{'say_error_handle'} = \*STDERR;

  ###############################################
  ## Marker-related Files
  ###############################################
  my $marker_hash = md5_hex( join( @{ $gConfig->{'input_file'} } ) );
  ## The marker file stores where we are in the file.  It's written
  ## to frequently during the job
  unless (defined $gConfig->{'marker_file'}) {
    $gConfig->{'marker_file'} = "/tmp/io_resume.mark.$marker_hash";
  }
  ## How often to update the marker
  unless (defined $gConfig->{'marker_interval'}) {
    $gConfig->{'marker_interval'} = 1;
  }
  ## The run file holds data persistant from run to run (i.e., this is
  ## the xth iteration)
  unless (defined $gConfig->{'run_file'}) {
    $gConfig->{'run_file'} = "/tmp/io_resume.run.$marker_hash";
  }

  ###############################################
  ## Skip or process only specific rows
  ###############################################
  if (defined $gConfig->{'rows'}) {
    $gConfig->{'rows'} = &expand_rows_format( $gConfig->{'rows'} ) ;
  } else {
    $gConfig->{'rows'}{'all'} = 1;
  }    
  if (defined $gConfig->{'skip'}) {
    $gConfig->{'skip'} = &expand_rows_format( $gConfig->{'skip'} ) ;
  } else {
    $gConfig->{'skip'} = {};
  }

  ###############################################
  ## Expand defaults
  ###############################################
  ## How often to report status update
  unless ($gConfig->{'status_row_count'}
          || $gConfig->{'status_second_count'}) {
    $gConfig->{'status_second_count'} = 30;
  }
  $gConfig->{'status_second_count'} ||= -1;
  $gConfig->{'status_row_count'}    ||= -1;

  say_debug( Dumper( $gConfig ) );
  
  return $gConfig;
}


########################################################  expand_rows_arg  ###
## 
sub expand_rows_format {
  my ($row_str) = @_;

  my @row1 = split /,/, $row_str;
  my @row2 = ();
  foreach my $r (@row1) {
    if ($r =~ /:/) {
      my ($start, $end) = split /:/, $r;
      push @row2, ($start .. $end);
    } else {
      push @row2, $r;
    }
  }

  my %h = map { $_ => 1 } @row2;
  return \%h;
}


##############################################################################
## Output methods:  say_status for status, say_output for output
sub say_status {
  return unless $gConfig->{'say_status_enabled'};
  my (@output) = @_;
  
  chomp $output[ $#output ];
  my $f = $gConfig->{'say_status_handle'};
  unless ($f) {
    confess("Can't say '", join("",@_),
            "' as file handles haven't been opened yet!");
  }
  print $f "INFO: ", @output, "\n";
}

sub say_debug {
  return unless $gConfig->{'say_debug_enabled'};
  my (@output) = @_;
  
  chomp $output[ $#output ];
  print STDERR "D: ", @output, "\n";
}

sub say_error {
  my (@output) = @_;
  
  chomp $output[ $#output ];
  my $f = $gConfig->{'say_error_handle'};
  unless ($f) {
    confess("Can't say '", join("", @_),
            "' as file handles haven't been opened yet!");
  }
  print $f "ERROR: ", @output, "\n";
}

sub say_warning {
  my (@output) = @_;
  
  chomp $output[ $#output ];
  my $f = $gConfig->{'say_error_handle'};
  unless ($f) {
    confess("Can't say '", join("", @_),
            "' as file handles haven't been opened yet!");
  }
  print $f "WARN: ", @output, "\n";
}

sub say_output {
  my $f = $gConfig->{'say_output_handle'};
  unless ($f) {
    confess("Can't say '", join("", @_),
            "' as file handles haven't been opened yet!");
  }
  unless (defined @_) {
    cluck("Nothing giving to output?");
  }
  print $f @_;
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

IO::Resume - Module for 

=head1 SYNOPSIS

  use IO::Resume;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for IO::Resume, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

=head1 Functions

=head2 run

=over

=item *
I<function> -- required.  Fuction reference to be called for each line of input.

=item *
I<input_file> -- input file

=item *
I<silent> -- disable status output

=item *
I<output_file> -- output file.  Note that status output isn't redirected here

=item *
I<status_file> -- status output file.  

=item *
I<error_file> -- error message file

=item *
I<status_second_count> --

=item *
I<status_row_count> --

=item *
I<row_start> -- row to start at

=item *
I<marker_file> --

=item *
I<marker_interval> --

=item *
I<> --

=item *
I<> --

=item *
I<> --

=item *
I<> --



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

William Reardon, E<lt>wdr1@localE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by William Reardon

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.


=cut
