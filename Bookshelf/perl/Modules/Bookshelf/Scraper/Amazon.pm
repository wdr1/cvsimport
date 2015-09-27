package Bookshelf::Scraper::Amazon;

use 5.006;
use strict;
use warnings;
use LWP::Simple;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Bookshelf::Scraper::Amazon ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.

## TODO:
## - test to w/ a known isbn to confirm data is correct

our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);
our $VERSION = '0.01';

our $BASE_URL = 'http://www.amazon.com/exec/obidos/tg/detail/-/';

# Preloaded methods go here.
sub get_isbn {
  my ($isbn) = @_;
  my (%r, $file, $content);

  $file = "/tmp/scrapper-amzn-$isbn.html";
  if (-f $file) {
    open(F, $file) || die ("Couldn't read '$file': $!");
    print "Loading from cache file '$file' ...\n";
    {
      local $/ = undef;
      $content = <F>;
    }
    close(F) || warn($!);
  } else {
    my $url = $BASE_URL . $isbn;
    print "Fetching: '$url' ...\n";
    $content = get( $url );
    open(F, ">$file") || die($!);
    print F $content;
    close(F) || warn ($!);
  }
  
  ## Get title
  ($r{title}) = $content =~ m|<title>.*?:.*?: (.*)</title>|s;
  $r{title} =~ s/^\s+//;
  $r{title} =~ s/\s+$//;

  ## Get authors
  (my $esc_title = $r{title}) =~ s/\W/\./;
  (my $author_str) = $content =~ m|<META name="description" content="$esc_title, (.*?)">|s;
  $r{authors} = [ split /,\s+/, $author_str ];
  
  return \%r;
}


1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Bookshelf::Scraper::Amazon - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Bookshelf::Scraper::Amazon;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Bookshelf::Scraper::Amazon, created by h2xs. It looks like the
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
