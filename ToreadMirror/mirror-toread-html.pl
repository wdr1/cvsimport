#!/usr/bin/perl -w

use strict;
use warnings;

use Data::Dumper;
use Cwd;
use LWP::Simple;

our $master_url = shift || 'http://del.icio.us/wdr1/toread?setcount=100';

our $WGET_MIRROR_COMMAND = "wget -e 'robots=off' -w1 -nd -U 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.12) Gecko/20080201 Firefox/2.0.0.12' -k -p -N  '__URL__'";
our $WGET_INDEX_PAGE_COMMAND = "wget -e 'robots=off' -w1 -nd -U 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.12) Gecko/20080201 Firefox/2.0.0.12' -k -p -N  '__URL__'";

our $MIRROR_DIRECTORY = 'Toread';
our $MIRROR_PREFIX = 'toread';
our $CWD = cwd();

our $TEST_CAP = 5;
  
&main();
sub main {
  &init();
  my $urls = &retreive_url_mirror_list( $master_url );
  my $url_metadata = &download_urls( $urls );
  &create_index_page( $url_metadata );
}


sub init {
  mkdir $MIRROR_DIRECTORY || die ($!);
}


sub retreive_url_mirror_list {
  my ($url) = @_;
  
  my $data;
#   open(F, "toread.html") || die($!);
#   {
#     local $/ = undef;
#     $data = <F>;
#   }
#   close(F) || warn($!);
  $data = get( $master_url );

  my $list = [];
  while ($data =~ m|<h4.*href="([^"]+)".*>([^<]+)</a>$|img) {
    push @$list, { 'url' => $1, 'title' => $2 };
    last if (scalar @$list >= $TEST_CAP);
  }

  return $list;
}


sub create_index_page {
  my ($url_list) = @_;

  my $index_file = 'index.html';
  print "Creating master index file '$index_file'...\n";
  
  open(F, '>', $index_file) || die ($!);
  foreach my $post (@$url_list) {
    print F join("", "<LI>", "<A HREF=", $post->{'local'}, ">",
                 $post->{'title'}, "</A>  (<A HREF=", $post->{'url'}, ">link</A>)\n");
  }
  close(F) || warn($!);
}

sub download_urls {
  my ($url_list) = @_;

  my $counter = 0;
  foreach my $post (@$url_list) {
    $counter++;

    my $local = sprintf("$MIRROR_DIRECTORY/$MIRROR_PREFIX%04d", $counter);
    $post->{'local'} = $local;
    unless (-d $local) {
      mkdir( $local ) || die ($!);
    }
    
    chdir $local;
    my $cmd = $WGET_MIRROR_COMMAND;
    $cmd =~ s|__URL__|$post->{'url'}|;
    system( $cmd );
    chdir $CWD;
  }

  return $url_list;
}
