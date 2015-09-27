#!/usr/local/bin/perl -w

##
## $Id: test.pl,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $
##
use strict;

use Test::More qw|no_plan|;
use Data::Dumper;

use lib '.';
use Blackjack;
ok(1); 

{

  my $new_shoe = &Blackjack::load_shoe();
  my $serialized_cookie = &Blackjack::serialize_cookied_shoe( $new_shoe );
  my $second_shoe =
    &Blackjack::deserialize_cookied_shoe( $serialized_cookie );
  
  is_deeply( $new_shoe, $second_shoe, "deserialized shoe");
  

  my $dup_str = '';
  my $cookies = &Blackjack::split_shoe_cookies($serialized_cookie, 200);
  foreach my $c (@$cookies) {
    $dup_str .= $c->value();
  }
  is( $dup_str, $serialized_cookie, "split_shoe_cookies - 200" );

  $dup_str = '';
  $cookies = &Blackjack::split_shoe_cookies($serialized_cookie);
  foreach my $c (@$cookies) {
    $dup_str .= $c->value();
  }
  is( $serialized_cookie, $dup_str, "split_shoe_cookies - default" );
  
}

