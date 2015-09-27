#!/usr/local/bin/perl -w

use Test::More qw|no_plan|;
use Data::Dumper;


use_ok( 'Blackjack::Config' );

{
  my $dir = '/foo/bar/baz/';
  my $c = Blackjack::Config->new( 'blackjack_base' => $dir,
                                );
  is( $c->blackjack_base(), $dir );
  is( $c->cached_shoe_load_path(), $dir . 'shoe_cache/' );
  
  my $c2 = Blackjack::Config->new();
  $c2->blackjack_base( $dir );
  is( $c2->blackjack_base(), $dir );
}

{
  package Blackjack::Config;
  use subs 'mkdir';
  
  package main;
  our @_TEST_MKDIR;
  *Blackjack::Config::mkdir = sub {
    push @_TEST_MKDIR, shift;
  };

  
  my $c = Blackjack::Config->new( 'blackjack_base' => '/doesnotexist/',
                                  'shoe_load_path' => '/doesnotexist/shoe_base',
                                );
  $c->prime_filesystem();
  our @EXPECTED = (
                   '/doesnotexist/',
                   '/doesnotexist/',
                   '/doesnotexist/shoe_cache/',
                   '/doesnotexist/',
                   '/doesnotexist/player_cache/',
                   '/doesnotexist/',
                   '/doesnotexist/shoe_base/'
                  );
  is_deeply( \@_TEST_MKDIR, \@EXPECTED, "Blackjack::Config::prime_filesystem");
}

