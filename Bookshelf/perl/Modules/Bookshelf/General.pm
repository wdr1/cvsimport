package Bookshelf::General;

use 5.006;
use strict;
use warnings;
use Data::Dumper;
use Bookshelf;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Bookshelf::General ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);
our $VERSION = '0.01';

$Bookshelf::Mapping{ 'version' } = { 'controller' => undef, 
                                     'view'       => \&version };
$Bookshelf::Mapping{ 'dump' }    = { 'controller' => undef, 
                                     'view'       => \&dump };

# Preloaded methods go here.
sub version {
  my ($cgi) = @_;

  ## This should probably dump the modules for each module
  print $cgi->header('text/plain');
  print $::VERSION, "\n";
  
}


sub dump {
  my ($cgi, $results) = @_;

  print $cgi->header('text/plain');
  print "=" x 20, "    cgi    ", "=" x 20, "\n";
  print Dumper( $cgi );
  print "=" x 20, "  results  ", "=" x 20, "\n";
  print Dumper( $results );
  print "=" x 20, " bookshelf ", "=" x 20, "\n";
  print Dumper( \%Bookshelf::Mapping );
}


1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Bookshelf::General - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Bookshelf::General;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Bookshelf::General, created by h2xs. It looks like the
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
