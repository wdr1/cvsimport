#!/usr/local/bin/perl -w

use strict;
use Data::Dumper;
use XML::Simple;
use Template;

our $xml_file = 'beastieboys.xml';
our $output_dir = 'html/';

my $data = XMLin( $xml_file );
$data->{ 'string_to_anchor' } = \&artist_album_to_anchor;

my $input = 'lyrics.tt';
my $tt = Template->new( {'INCLUDE_PATH' => 'presentation'} );
$tt->process($input, $data, $output_dir . 'test.html') || die($!);



sub artist_album_to_anchor {
  my ($artist, $album) = @_;

  $artist =~ s/\W/_/g;
  $album  =~ s/\W/_/g;
  
  return "/$artist.html#$album";
}
