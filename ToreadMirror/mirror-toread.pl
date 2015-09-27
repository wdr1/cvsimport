#!/usr/bin/perl -w

use strict;
use warnings;

use Data::Dumper;
use Cwd;
use LWP::Simple;
use XML::Simple;

our $DEBUG = 0;

our $master_url = 'https://__USER__:__PASSWORD__@api.del.icio.us/v1/posts/all?tag=toread';

our $USER = shift;
our $PASSWORD = shift;

our $WGET_MIRROR_COMMAND = "wget -e 'robots=off' -w1 -nd -U 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.12) Gecko/20080201 Firefox/2.0.0.12' -k -p -N  '__URL__'";

our $MIRROR_DIRECTORY = 'Toread';
our $MIRROR_PREFIX = 'toread';
our $CWD = cwd();

our $LINK_NAME = "00index.html";

our $CRAWL_CAP = 5000;
$CRAWL_CAP = 5 if ($DEBUG);
  
&main();
sub main {
  &init();
  my $urls = &retreive_url_mirror_list( $master_url );
  my $url_metadata = &download_urls( $urls );
  &create_index_page( $url_metadata );
}


sub init {
  die("Missing username...\n") unless ($USER);
  die("Missing password...\n") unless ($PASSWORD);

  $master_url =~ s|__USER__|$USER|;
  $master_url =~ s|__PASSWORD__|$PASSWORD|;
  
  mkdir $MIRROR_DIRECTORY || die ($!);
}


sub retreive_url_mirror_list {
  my ($url) = @_;

  ## I have no f'ing idea why LWP::Simple's get works in the debugger, but not here.
  my $xml_response;
  unless ($DEBUG) {
    $xml_response = `curl $master_url`;
  } else {
    local $/ = undef;
    print "== Using Local File!! ==\n";
    open(F, "toread.xml") || die($!);
    $xml_response = <F>;
    close(F);
  }
  die("No xml reponse!") unless ($xml_response);
  my $data = XMLin( $xml_response );
  
  my $list = $data->{'post'};
  foreach my $i (@$list) {
    ## Backwards compatible w/ previous verson
    $i->{url} = $i->{href};
    $i->{title} = $i->{description};
  }

  splice @$list, $CRAWL_CAP;
  
  return $list;
}


sub create_index_page {
  my ($url_list) = @_;

  my $index_file = 'index.html';
  print "Creating master index file '$index_file'...\n";
  
  open(F, '>', $index_file) || die ($!);
  foreach my $post (@$url_list) {
    print F join("", "<LI>", "<A HREF=", $post->{'local'}, "/$LINK_NAME>",
                 $post->{'title'}, "</A>  (<A HREF=", $post->{'url'}, ">link</A>)\n");
  }
  close(F) || warn($!);
}

sub download_urls {
  my ($url_list) = @_;

  my $counter = 0;
  foreach my $post (@$url_list) {
    $counter++;

    print "=" x 78, "\n";
    print "== ($counter)   ", $post->{'url'}, "\n";
    print "=" x 78, "\n";

    my $local = join("", $MIRROR_DIRECTORY, "/",
                     $MIRROR_PREFIX, "-",
                     $post->{'hash'});
    $post->{'local'} = $local;
    if (-d $local) {
      print "...Skipping -- '$local' exists...\n";
      next;
    } else {
      mkdir( $local ) || die ($!);
    }
    
    chdir $local;
    my $cmd = $WGET_MIRROR_COMMAND;
    $cmd =~ s|__URL__|$post->{'url'}|;
    system( $cmd );
    my ($file) = $post->{'url'} =~ m|/([^/]+)$|;
    link( $file, $LINK_NAME) || warn($!);
    chdir $CWD;
  }

  return $url_list;
}
