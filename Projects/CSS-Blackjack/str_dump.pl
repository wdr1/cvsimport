#!/usr/local/bin/perl -w

use strict;
use Storable;
use Data::Dumper;

my $file = shift;

my $ref = retrieve( $file );
print Dumper( $ref );
