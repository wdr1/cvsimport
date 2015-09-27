#!/usr/local/bin/perl

use strict;
use warnings;

use Test::More tests => 8;
use Data::Dumper;

use Blackjack::Config;
use Blackjack::Player;

use_ok( 'Blackjack::PlayerShoe' );

my $tc = new Blackjack::Config;
my $player = new Blackjack::Player ( 'config' => $tc,
                                     'email' => 'wdr1@pobox.com',
                                   );
my $player_shoe = new Blackjack::PlayerShoe( 'config' => $tc,
                                             'player' => $player );

$player_shoe->load_player_shoe();

is( $player_shoe->incorrect_response_weight(), 2, "incorrect_response_weight");
is( $player_shoe->initial_hand_weight(), 2, "initial_hand_weight");

my ($count, $total_weight);
## Validate 'deal'
my $empty = 0;
$count = 1000;
while ($count--) {
  my $hand = $player_shoe->deal();
  unless (defined($hand) && ref($hand) eq 'HASH') {
    $empty++;
  }
}
ok($empty == 0, "Dealt $empty empty arrays...");

## Load 'tiny' shoe & poke at it
my $tiny_player = new Blackjack::Player ( 'config' => $tc,
                                          'shoe_type' => 'tiny',
                                          'email' => "$$\@unittest.foo",
                                        );

my $tiny_shoe = new Blackjack::PlayerShoe( 'config' => $tc,
                                           'shoe_type' => 'tiny',
                                           'player' => $tiny_player );
$tiny_shoe->deal();
is($tiny_shoe->weight(), 3, "Tiny shoe weight");

$total_weight = $tiny_shoe->weight();
$count = 0;
while (1) {
  my $hand = $tiny_shoe->deal();
  last unless($hand);
  my $key = $tiny_shoe->hand2key( $hand->{hand} );
  $tiny_shoe->register_response( $key, 1);
  last if ($count > 100);
  $count++;
}
is($count, $total_weight, "Tiny Shoe: Dealt all hands");

$tiny_shoe->reset_shoe();
is ($tiny_shoe->weight(), $total_weight, "Tiny Shoe: Weight after reset");
{
  my ($hand, $key);
  $hand = $tiny_shoe->deal();
  $key = $tiny_shoe->hand2key( $hand->{hand} );
  $tiny_shoe->register_response( $key, 0);

  $count = 0;
  while (1) {
    $hand = $tiny_shoe->deal();
    last unless($hand);
    $key = $tiny_shoe->hand2key( $hand->{hand} );
    $tiny_shoe->register_response( $key, 1);
    last if ($count > 100);
    $count++;
  }
  is($count, $total_weight + 2, "Tiny Shoe: Correct handling of incorrect answer");
}
