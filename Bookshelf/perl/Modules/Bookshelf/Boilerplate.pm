package Bookshelf::Template;

use 5.006;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Bookshelf::Template ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);
our $VERSION = '$Revision: 1.1.1.1 $ ';

## This module is pretty much for slurping up template files
$Bookshelf::Mapping{ 'version' } = { 'controller' => undef, 
                                     'view'       => \&version };


1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Bookshelf::Template - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Bookshelf::Template;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Bookshelf::Template, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.


=head1 AUTHOR

A. U. Thor, E<lt>a.u.thor@a.galaxy.far.far.awayE<gt>

=head1 SEE ALSO

L<perl>.

=cut
