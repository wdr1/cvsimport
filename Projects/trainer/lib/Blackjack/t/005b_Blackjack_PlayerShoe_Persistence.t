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
my $hand = $tiny_shoe->load_player_shoe();
is($tiny_shoe->incorrect_response_weight(), 2, "incorrect_response_weight");
is ($tiny_shoe->weight(), 5, "serialized shoe weight");
