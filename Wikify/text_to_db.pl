#!/usr/local/bin/perl -w

## $Id: text_to_db.pl,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

use strict;
use DB_File;

my $text_file = shift;
my $db_file   = shift;

my (%db, $key, $value);
tie %db,  "DB_File", $db_file, O_RDWR, 0666, $DB_HASH or die($!);

open(F, "<", $text_file) || die("Couldn't write to '$text_file': $!");
while ( <F> ) {
  chomp;
  ($key, $value) = split /::/, $_;
  $db{ $key } = $value;
}
