#!/usr/bin/perl

use strict;
use warnings;

use CGI;
#use CGI::Carp;
use CGI::Carp qw|fatalsToBrowser|;
use JSON;
use Data::Dumper;
use List::Util qw(min);

use lib '/home/wdr1/Projects/trainer/lib';

use Blackjack::Config;
use Blackjack::Player;
use Blackjack::PlayerShoe;

our $cgi = new CGI;
our ($config, $player, $shoe);

our %ACTIONS = ( 'd' => \&deal_hand,
                 'r' => \&register_hand,
                 'status' => \&show_shoe_status,
                 'get_deck_images' => \&get_deck_images,
               );

my $email = $cgi->param('e') || die("No player given!");
my $action = $cgi->param('a') || die("No action given!");

&init();
if (exists( $ACTIONS{ $action } )) {
  &{ $ACTIONS{ $action } };
} else {
  die("Undefined action '$action'!");
}


sub init {
  $config = new Blackjack::Config(
               'blackjack_base' => '/home/wdr1/Projects/trainer/',
               'shoe_load_path' => '/home/wdr1/Projects/trainer/starting_shoes/',
  );
  $player = new Blackjack::Player( 'config' => $config,
                                   'email'  => $email );
  $shoe = new Blackjack::PlayerShoe( 'config' => $config,
                                     'player' => $player );
}


sub deal_hand {
  my $size = $cgi->param('s') || 3;
  $size = $size > 0 ? $size : 3;
  my @hand = $shoe->deal($size);
  print CGI::header( -content_type => "application/json; charset=utf-8" );
  print objToJson( \@hand ), "\n";
}


sub show_shoe_status {

  $shoe->load_player_shoe() unless ($shoe->is_shoe_loaded());

  print CGI::header();
  my $hands = $shoe->shoe()->{hands};
#  print Dumper( $hands );
  my $html = "<TABLE BORDER=1>\n";
  
  ## ... Header ...
  $html .= join('', "<TR><TD></TD>\n",
                map { "\t<TD class=cStatusGridHeader>$_</TD>\n" } (2 .. 10, 'A'),
                "</TR>\n");
  
  ## ... Hard Totals ...
  my @hard_totals = ( [2,7], [2,8], [2,9], [3,9], [4,9], [5,9], [6,9], [7,9], [8,9], [8,10], [9,10] );
  foreach my $player_cards (reverse @hard_totals) {
    my $row_started = 0;
    my ($player1, $player2) = @$player_cards;
    
    $html .= "<TR><TD>" . ($player1 + $player2) . "</TD>\n";
    foreach my $dealer (2 .. 11) {
      my $key = "$dealer-$player1-$player2";
      my $weight = min( $hands->{$key}{w}, 4 );
      my $answer = $hands->{$key}{a};
      $html .= "\t<TD class=cStatusGrid$weight>$answer</TD>\n";
    }
    
    $html .= "</TR>\n";
   }

  ## ... Soft Totals ...
  foreach my $player1 (2 .. 9) {
    $html .= "<TR><TD>A, $player1</TD>\n";
    foreach my $dealer (2 .. 11) {
      my $key = "$dealer-$player1-11";
      my $weight = min( $hands->{$key}{w}, 4 );
      my $answer = $hands->{$key}{a};
      $html .= "\t<TD class=cStatusGrid$weight>$answer</TD>\n";
    }
    $html .= "</TR>\n";
  }

  ## ... Splits ...
  foreach my $player1 (2 .. 11) {
    $html .= "<TR><TD>$player1, $player1</TD>\n";
    foreach my $dealer (2 .. 11) {
      my $key = "$dealer-$player1-$player1";
      my $weight = min( $hands->{$key}{w}, 4 );
      my $answer = $hands->{$key}{a};
      $html .= "\t<TD class=cStatusGrid$weight>$answer</TD>\n";
    }
    $html .= "</TR>\n";
  }
  
  $html .= "</TABLE>\n";
  print $html;
}


sub register_hand {
  my $hand = $cgi->param( 'hand' );
  my $response = $cgi->param('response');

  unless ( defined($hand) && defined($response) ) {
    die( "Missing hand or reponse..." );
  }

  $shoe->register_response( $hand, $response );
  print CGI::header( -content_type => "application/json; charset=utf-8" );
  print objToJson( { 'error' => 0 } ), "\n";
}


sub get_deck_images {
  my $deck = $cgi->param('deck') || 'plain';
  my $base_dir = '/home/wdr1/Projects/trainer/deckimages/' . $deck . '/' ;
  my $base_url = 'http://wdr1.com/trainer/deckimages/' . $deck . '/';

  my $images = {};
  opendir(BASE, $base_dir) || die($!);
  my @all_files = readdir(BASE);
  $images->{face} = $base_url . ( grep { /^facedown/ } @all_files )[0];
  my @subdirs =
    grep { -d "$base_dir/$_/" } grep { ! /^\./ } @all_files;
  
  foreach my $d (@subdirs) {
    opendir(SUBDIR, "$base_dir/$d/") || die($!);
    my @files = grep { -f "$base_dir/$d/$_" } readdir(SUBDIR);
    foreach my $f (@files) {
      push @{ $images->{ $d } },
        $base_url . $d . '/' . $f;
    }
  }

  print CGI::header( -content_type => "application/json; charset=utf-8" );
  print objToJson( $images,
                   { 'pretty' => 1,
                     'indent' => 2,
                   }
                 ), "\n";
}
