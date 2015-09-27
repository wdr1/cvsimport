#!/usr/local/bin/perl -w

use strict;
use XML::Simple;
use Data::Dumper;
  

opendir(DIR, '.') || die($!);
my @files = grep { ! /^\./ } grep { /\.html$/ } readdir DIR;
closedir(DIR) || warn($!);

our %songs = &load_song_order();

my @songs = ();
foreach my $f (@files) {
  my ($title, $lyrics);

  my %h = ();
  local $/ = undef;
  open(F, '<', $f) || die($!);
  my $web_page = <F>;
  close(F) || warn($!);
  
  ($title)  = $web_page =~ m|<B>"([^"]+)"</b><BR><BR>|sm;
  ($lyrics) = $web_page =~ m|</b><BR><BR>\r\n(.*?)<BR><BR>|ms;
  $lyrics =~ s|<br>||gi;

  my $track = $songs{ $title }->{ 'track' } || '';
  %h = ( 'title'   => $title,
         'content' => $lyrics,
         'track'   => $track,
       );
  push @songs, \%h;
  
#   print "=" x 78, "\n";
#   print "Processing '$f'...\n";
#   print "Title: $title\n";
#   print $lyrics;
}

my $xml = {};
$xml->{'artist'}{'name'} = 'Beastie Boys';
foreach my $song (@songs) {
  my $album = $songs{ $song->{'title'} }->{ 'album' } || 'unknown';
  push @{ $xml->{'artist'}{'album'}{ $album }{'song'} },
    $song;
}

#print Dumper( $xml );

foreach my $album (keys %{ $xml->{'artist'}{'album'} }) {
  $xml->{'artist'}{'album'}{ $album }{'song'} =
    [ sort { $a->{'track'} <=> $b->{'track'} }
      @{ $xml->{'artist'}{'album'}{ $album }{'song'} } ]; 
}

my $xml_output = XMLout( $xml );
print $xml_output;

########################################################  load_song_order  ###
## 
sub load_song_order {
  my $file = 'songs.txt';

  my %track_lookup;
  my $album = '<unknown>';
  my $track_number = 1;
  
  open(F, '<', $file) || die($!);
  while (<F>) {
    my ($tmp) = $_ =~ /^album: "([^"]+)"/;
    if ($tmp) {
      $album = $tmp;
      $track_number = 1;
      next;
    }

    next if (/^\s/);

    chomp;
    $track_lookup{ $_ } = { 'album' => $album,
                            'track' => $track_number };
    $track_number++;
  }

  return %track_lookup;
}


