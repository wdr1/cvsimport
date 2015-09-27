#!/usr/local/bin/perl -w

use strict;
use Data::Dumper;
use lib 'Modules';
use Bookshelf::Scraper::Amazon;


my $isbn = shift;

my $r = Bookshelf::Scraper::Amazon::get_isbn( $isbn );
print Dumper( $r );
