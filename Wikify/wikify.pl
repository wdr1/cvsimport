#!/usr/local/bin/perl -w

## $Id: wikify.pl,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

use Wikify qw|wikify_text|;
use Data::Dumper;

## Input file
my $file = shift;
die("no file!") unless ($file);
die("Can't find '$file'") unless (-f $file);

open(F, "<", $file) || die($!);
{
  $/ = undef;
  my $text = <F>;
  my ($wikified_text, $terms) = &wikify_text( $text );
  print "Out: $wikified_text";
  print Dumper( $terms );
}

