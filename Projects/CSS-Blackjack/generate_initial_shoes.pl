#!/usr/local/bin/perl -w

## $Id: generate_initial_shoes.pl,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

##
## Generate the initial shoes & store them in a "forzen" state, so they
## don't need to be re-generated each time they're needed.
##
## Right now, only handles one type of shoe, but in the future may handle more 
## permutations.


use strict;
use Storable;
use IO::All;

our $DIR = '/home/wdr1/Projects/CSS-Blackjack/rules';

&main();

sub main {
  &standard_shoe('rules_strip_basic.txt');
}

##########################################################  standard_shoe  ###
## 
sub standard_shoe {
  my ($file) = @_;

  my (@index, $outfile) = ();
  
  open(F, '<', "$DIR/$file") || die ("Couldn't read '$DIR/$file': $!");
  while (<F>) {
    next if (/^\s*#/);
    my ($p1, $p2, @actions) = split /,/, $_;
    my $hint = pop @actions;
    foreach my $d (qw|2 3 4 5 6 7 8 9 10 11|) {
      my $a = shift @actions;
      next if ($a eq '-');
      push @index, "$p1,$p2,$d,$a";
    }
  }
  close(F) || warn($!);

  my $sfile;
  ($sfile = $file) =~ s/\.txt$/\.str/;
  print "Writing ", scalar @index, " entries to '$DIR/$sfile'...\n";
  store \@index, "$DIR/$sfile" || die($!);
  
}


