#!/usr/local/bin/perl

use strict;
use warnings;

use Test::More tests => 6;
use Data::Dumper;

use_ok( 'Blackjack::Player' );
use Blackjack::Config;

my $tc     = new Blackjack::Config;
my $schema = $tc->get_schema();

my $player = { 'email'     => 'unittest@example.com',
               'password'  => 'randi',
               'shoe_type' => 'simple',
               'name'      => 'Unit Tester',
             };


## Purge entries from prior tests
$schema->resultset('Blackjack')->search( { 'email' => $player->{email} } )->delete;

my $created = Blackjack::Player->create_player({ 'player' => $player,
                                                 'config' => $tc
                                                });
my $lookup_player = Blackjack::Player->load_player( 'player_email' => $player->{email},
                                                    'config' => $tc );
                                             
my %db_player =
  $schema->resultset('Blackjack')->search( { 'email' => $player->{email} } )->next->get_columns;

foreach my $f (keys %db_player) {
  is( $lookup_player->$f(), $db_player{ $f }, "Checking '$f'...");
}
