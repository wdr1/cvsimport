package Debug;

use 5.008001;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Debug ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	debug
);

our $VERSION = '$Revision: 1.1.1.1 $ ';

our $DEBUG_LEVEL = 0;

sub debug {
    my ($level);

      $level = pop @_;
    if ($level !~ /^\d+$/) {
          push @_, $level;
              $level = 1;
        }

    if ($level <= $DEBUG_LEVEL) {
          my $str = join("", @_);
              chomp($str);
              print STDERR "DEBUG: $str\n";
        }
    }



# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Debug - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Debug;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Debug, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>wdr1@(none)E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
