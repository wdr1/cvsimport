#!/usr/local/bin/perl -w

## $Id: extract_skip_term.pl,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

use strict;
use DB_File;

my @input  = ('/usr/share/dict/words', '/usr/share/dict/connectives');
my $output = 'skip.db';

my %terms = ();

tie %terms, "DB_File", $output, O_RDWR|O_CREAT, 0666, $DB_HASH or die($!);

my $term_count = 0;

foreach my $input (@input) {
  die("Couldn't read '$input'...\n") unless (-e $input);
  open(F, '<', $input) || die($!);
  print "Processing '$input'...\n";
  
  while( <F> ) {
    next if (/^[A-Z]/);
    chomp;
    $term_count++;
    $terms{ lc( $_ ) } = 1;
    print "$term_count terms found.\n" unless ($term_count % 5000);
  }
}

## Manual skip terms
$terms{ "'s" } = 1;

print scalar keys %terms," skip terms found.\n";
untie( %terms );
