#!/usr/local/bin/perl -w

## $Id: extract_wiki_term.pl,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

use strict;
use DB_File;

my $input  = shift;
my $output = 'wikify.db';

die("Couldn't read '$input'...\n") unless (-e $input);

my %terms = ();

tie %terms, "DB_File", $output, O_RDWR|O_CREAT, 0666, $DB_HASH or die($!);

my $term_count = 0;

open(OUT, ">", "debug.txt") || die($!);

open(F, '<', $input) || die($!);
while( <F> ) {
  my ($title) = $_ =~ m|^\s*<title>([^<>]+)</title>|;
  if ($title) {
    next if ($title =~ m|^Talk:|);
    next if ($title =~ m|^User:|);
    next if ($title =~ m|^Image:|);

    $term_count++;
    my $encoded_title = $title;
    $encoded_title =~ s/ /_/g;
    $terms{ lc( $title) } = $encoded_title;
    print OUT lc( $title), " => $encoded_title\n";

    print "$term_count terms found.\n" unless ($term_count % 5000);

  }
}

untie( %terms );

print "$term_count terms found.\n";
