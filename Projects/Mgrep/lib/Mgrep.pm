package Mgrep;

use 5.006001;
use strict;
use warnings;

use Data::Dumper;

require Exporter;

our @ISA = qw(Exporter);

## $Id: Mgrep.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Mgrep ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10);
our $DEBUG = $ENV{ 'MGREP_DEBUG' } || 0;



###################################################################  main  ###
## Nothing outside this loop should generate output to faciliate debugging. 
sub main {
  print &main_no_print( @ARGV );
}


##########################################################  main_no_print  ###
## Testing's harder if everything goes to STDOUT
sub main_no_print {
  my $cfg = parse_commandline( @_ );
  debug( Dumper( $cfg ) );

  my $output = '';
  foreach my $mailbox ( @{ $cfg->{'_mailboxes'} } ) {
    $output .= check_mailbox( $cfg, $mailbox );
  }

  return $output;
}


##########################################################  check_mailbox  ###
## Look for matches within a single mailbox.
sub check_mailbox {
  my ($cfg, $mailbox) = @_;
  my ($header, $body);

  my $next_msg = get_mbox_iterator( $mailbox );
  while (($header, $body) = &$next_msg() ) {
    my $patterns = &build_header_patterns( $cfg->{'_matches'} );
    if ( is_a_match( $header, $body, $patterns ) ) {
      format_match( $cfg, $header );
    }
  }
  
}


############################################################  format_match  ###
## 
sub format_match {
  my ($cfg, $header) = @_;
  
  my $format = $cfg->{'result_format'};
  my $header_hash = { map { split /\s*: \s*/ } ( split /\n/, $header ) };

  my $result = sprintf( $cfg->{'rf_sprintf'},
                        map { $header_hash->{ $_ } || '' }
                            @{ $cfg->{'rf_columns'} } );

  return $result;
}


####################################################  format_match_header  ###
## 
sub format_match_header {
  my ($cfg) = @_;


  my $result = sprintf( $cfg->{'rf_sprintf'},
                        @{ $cfg->{'rf_columns'} } );

  my $dashes = $cfg->{result_format};
  $dashes =~ s/\b[^: ]+:(\d+)/'-' x $1/ge;
  $result .= $dashes;

  return $result;
}


#############################################################  is_a_match  ###
## 
sub is_a_match {
  my ($msg_header,  ## the message headers
      $msg_body,    ## the message bodies
      $patterns,    ## patterns to match as returned by build_header_patterns
      $match_any    ## if we need to match any or all
     ) = @_;

  $match_any ||= 1;

  my $matches = 0;
#  print Dumper( $patterns );
  foreach my $pattern (@$patterns) {
#     print "=" x 78, "\n";
#     print $msg_header;
#     print "-" x 78, "\n";
#     print $pattern;
    if ($msg_header =~ m/$pattern/m) {
      print "Match!\n";
      $matches++;
      last if ($match_any);
    }
  }

  if ($match_any && $matches) {
    return 1;
  } elsif ($matches = scalar @$patterns) {
    return 1;
  } else {
    return 0;
  }
}


##################################################  build_header_patterns  ###
## 
sub build_header_patterns {
  my ($h) = @_;
  my @patterns;

  foreach my $k (keys %$h) {
    $k =~ s/:\s*//;
    $k = ucfirst( $k );
    push @patterns, "^$k: .*" . $h->{$k} . '';
  }

  return \@patterns;
}


######################################################  get_mbox_iterator  ###
## 
sub get_mbox_iterator {
  my ($file) = @_;
  my ($open);
  $open = 0;
  local(*F);

  return sub {
    unless ($open) {
      open(F, "<", $file) || die("Couldn't read '$file': $!");
      <F>;
      $open = 1;
    }

    my %data = ();
    my $key = 'header';
    while (<F>) {
      last if ($_ =~ /^From /);
      if ($key eq 'header' && $_ =~ /^$/) {
        $key = 'body';
      } else {
        $data{ $key } .= $_;
      }
    }
    ## Flatten multi-line headers
    if ($data{'header'}) {
      $data{'header'} =~ s/\n\t/ /g;
    }
    
    return ($data{'header'}, $data{'body'});
  }
}


########################################################  parse_commandline ##
## 
sub parse_commandline {
  my (@c) = @_;
  my (%h);

  our $HELP=<<__HELP__;
TODO: explain help
__HELP__
  
  ## These are switches that don't take a value
  my %explict_options = ( 'help' => 1, 'verbose' => 1 , 'debug' => 1 );
  
  $h{'_matches'} = {};
  $h{'_mailboxes'} = [];
  
  while (@c) {
    my $k = shift @c;
    
    ## Check if the current value is a switch
    if (substr($k, 0, 1) eq '-') {
      $k =~ s/^\-+//;
      
      if ($explict_options{ $k }) {
        $h{ $k } = 1;
      } elsif ($k =~ /^\d+$/) {
        $h{ 'msg_num' } = $k;
      } elsif (@c) {
        if (@c) {
          my $v = shift @c;
          $h{_matches}{ $k } = $v;
        } else {
          warn("What'd you want me to do with '$k' option?  Ignoring...\n");
        }
      }
    } else {
      push @{ $h{ '_mailboxes' } }, $k;
    }
  }

  ## If no matches, then what we thought was the first mailbox
  ## is a string we should search From & Subject for.  
  ## E.g., mgrep 'subject string' <mailboxes>
  unless (%{ $h{'_matches'} }) {
    if (scalar @{ $h{'_mailboxes'} } > 1) {
      my $pattern = shift @{ $h{'_mailboxes'} };
      $h{'_matches'}{'From'}    = $pattern;
      $h{'_matches'}{'Subject'} = $pattern;
    }
  }
  

  ## Results Format
  ## TODO: enhance this latter (configurable, explain options)
  $h{'result_format'} = "From:15 Subject:50\n";
  ($h{'rf_sprintf'} = $h{'result_format'}) =~ s|\b[^: ]+:(\d+)|\%\-$1\.$1s|g;
  $h{'rf_columns'} = [ $h{'result_format'} =~ m|\b([^: ]+):\d+|g ];

  return \%h;
}


##################################################################  debug  ###
## 
sub debug {
  return unless ($DEBUG);
  
  my (@msgs) = @_;
  chomp $msgs[ $#msgs ];
  print "DEBUG: ", @msgs, "\n";
}




# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Mgrep - Perl extension for grepping through mail

=head1 SYNOPSIS

  use Mgrep;


=head1 DESCRIPTION

Stub documentation for Mgrep, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

=head1 Shortcuts

=over 3

=item -f    -- Search 'From'


=item -t    -- Search 'To'


=item -too  -- Search 'To' and 'Cc'

=back

=head1 SEE ALSO

Location of mbox documentation



=head1 AUTHOR

William Reardon, E<lt>wdr1@pobox.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by William Reardon

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.


=cut
