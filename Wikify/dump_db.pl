#!/usr/local/bin/perl -w

use strict;
use DB_File;

my $file = shift;
my %terms;
tie %terms, "DB_File", $file, O_RDWR|O_CREAT, 0666, $DB_HASH or die($!);

my ($k, $v);
while ( ($k, $v) = each %terms ) {
  print "'$k' => '$v'\n";
}
