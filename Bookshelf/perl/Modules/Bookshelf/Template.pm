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
$Bookshelf::Mapping{ 'template' } =
  { 'controller' => undef, 
    'view'       => \&template };

our %DEFAULT_CONFIG = (
                       INCLUDE_PATH => $Bookshelf::tt_dir,
                       INTERPOLATE  => 1,               
                       PRE_CHOMP   => 1,               
                       POST_CHOMP   => 1,               
                       PRE_PROCESS  => 'header',        
                       EVAL_PERL    => 1,               
                      );

sub template {
  my ($cgi, $results) = @_;

  my %config = %DEFAULT_CONFIG;

  ## Allow results to override which page to display
  ## (This allows a controller to dicate an error, etc. page
  my $tfile = $results->{tfile} || $cgi->param('tfile');
  die("No template file passed to template!") unless ($tfile);

  my $t = Template->new( \%config );
  $t->process( $tfile, $results) ||
    die $t->error();
}


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
