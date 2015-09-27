#!/usr/local/bin/perl -w

# $Id: find_path.pl,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use strict;
use IO::All;
use HTML::TreeBuilder 3;
use Data::Dumper;


&main(@ARGV);

sub main {
  my ($file, $phrase) = @_;
  
  print "Looking for '$phrase' in '$file'...\n";
  my $tree = HTML::TreeBuilder->new();
  $tree->parse_file($file);   

  unless ( $tree->as_text =~ /$phrase/) {
    die("I can't find that?\n");
  }

  my $stack = locate_text( $tree, $phrase );
  print join(", ", @$stack), "\n";
  
}

sub locate_text {
  my ($tree, $phrase, $stack) = @_;

  $stack ||= [];

  my @children = $tree->content_list();
  for my $i (0 .. $#children) {
    if (ref($children[ $i ]) eq 'HTML::Element' and 
        $children[ $i ]->as_text =~ /$phrase/) {
      push @$stack, $i;
      return &locate_text( $children[ $i ], $phrase, $stack );
    }
  }

  return $stack;
}

