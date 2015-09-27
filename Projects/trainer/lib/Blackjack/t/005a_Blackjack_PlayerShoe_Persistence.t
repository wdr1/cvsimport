#!/usr/local/bin/perl

use strict;
use warnings;

use Test::More qw|no_plan|;
use Data::Dumper;

use Blackjack::Config;
use Blackjack::Player;

use_ok( 'Blackjack::PlayerShoe' );

my $tc = new Blackjack::Config;
my $tiny_player = new Blackjack::Player ( 'config' => $tc,
                                          'shoe_type' => 'tiny',
                                          'email' => 'persistence@example.foo',
                                        );

my $tiny_shoe = new Blackjack::PlayerShoe( 'config' => $tc,
                                           'player' => $tiny_player );
my $hand = $tiny_shoe->deal();
my $key = $tiny_shoe->hand2key( $hand->{hand} );
is($tiny_shoe->incorrect_response_weight(), 2, "incorrect_response_weight");
is ($tiny_shoe->weight(), 3, "pre-fail shoe weight");
$tiny_shoe->register_response( $key, 0);
is ($tiny_shoe->weight(), 5, "post-fail shoe weight");
