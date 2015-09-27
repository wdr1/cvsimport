#!/usr/local/bin/perl -w

use strict;
use XML::Simple;
use Data::Dumper;
use Wikify qw|wikify_text|;

our $input  = 'beastieboys_small.xml';
our $output = 'beastieboys_wikified.xml';

my $data = XMLin( $input,
                  ForceArray => [ 'artist', 'album', 'song' ],
                );

foreach my $artist ( keys %{ $data->{artist} } ) {
  our %backlinks = ();
  foreach my $album (keys %{ $data->{artist}{$artist}{album} } ) {
    foreach my $song ( @{ $data->{artist}{$artist}{album}{$album}{song} }) {
      print "Processing $artist - $album - $song->{title}\n";
      my $lyrics = $song->{content};
      my ($wiki_lyrics, $terms) = wikify_text( $lyrics );
      $song->{content} = $wiki_lyrics;

      foreach my $term (keys %$terms) {
        push @{ $data->{artist}{$artist}{backlink} },
          { 'album' => $album,
            'title' => $song->{title},
            'term'  => $term,  };
      }
    }
  }
}

my $new_xml = XMLout( $data );
open (F, ">",  $output) || die($!);
print F $new_xml;
close(F) || warn($!);
