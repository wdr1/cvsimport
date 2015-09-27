#!/usr/local/bin/perl -w

use strict;
use XML::Simple;
use Data::Dumper;

my $file = shift;
my $ref = XMLin( $file );
print Dumper( $ref );
print XMLout( $ref );
