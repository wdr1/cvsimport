package Blackjack;

## $Id: Blackjack.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use strict;
use warnings;

use CGI;
use Data::Dumper;
use Storable qw|freeze thaw retrieve|;

use MIME::Base64;
use Compress::Zlib;

our @ISA=qw(Exporter);

our $CGI = new CGI;
our $DEBUG = $ENV{'DEBUG'} || $CGI->param('debug') || 0;
our $RULES_DIR = '/home/wdr1/Projects/CSS-Blackjack/rules';

sub deal {
  ## Get a shoe from the cookie or create a new one
  my $shoe = &combine_shoe_cookies();
  if (scalar @$shoe == 0) {
    print STDERR "Getting new shoe...\n";
    $shoe = &new_player();
  }

  ## Did they get the action right or wrong?
  ## (No action may have been passed, which is okay (e.g., initial request))
  my $action = $CGI->param('a');
  if (defined $action && $action eq 'w' ) {
    push @$shoe, $shoe->[0];
    push @$shoe, $shoe->[0];
    push @$shoe, $shoe->[0];
  }
  if ($action) {
    shift @$shoe;
    if (scalar @$shoe > 2) {
      my $i = int(rand( scalar( @$shoe ) - 1 )) + 1;
      ($shoe->[1], $shoe->[$i]) = ($shoe->[$i], $shoe->[1]);
    }
    if (scalar @$shoe == 0) {
      push @$shoe, '-';
    }
  }
  
  ## How many hands to return (either 1 or 2)
  my $hands_wanted = $CGI->param('hw');
  $hands_wanted ||= 1;

  ## Send the response back to the client
  &print_client_response( $shoe, $hands_wanted );
}


##################################################  print_client_response  ###
## 
sub print_client_response {
  my ($shoe, $hw) = @_;

  $hw ||= 1;

  my $compressed_shoe = serialize_cookied_shoe ( $shoe );
  my $cookies = split_shoe_cookies( $compressed_shoe);

  print $CGI->header( -cookie => $cookies );
  print join(":", @$shoe[ 0 .. $hw - 1 ]), "\n";

  if ($DEBUG) {
    print "<pre>\n";
    print "Shoe size: ", scalar @$shoe, "\n";
    print Dumper( $shoe );
    print "</pre>\n";
  }
}


##########################################################  reset_cookies  ###
## 
sub reset_cookies {
  my $i = 0;
  my @cookies = map { $CGI->cookie( -name => 's' . $_, 
                                    -value => '',
                                    -expires => '-1d' ) } (0 .. 9, '');
  print $CGI->header( -cookie => \@cookies );
  print "Cookies reset.\n";
}


##############################################################################
##                  Cookie Functions 
##############################################################################


###################################################  combine_shoe_cookies  ###
## 
sub combine_shoe_cookies {
  
  my $str = '';
  for my $i (0 .. 9) {
    if ($CGI->cookie("s$i")) {
      my $c = $CGI->cookie("s$i");
      chomp( $c );
      $str .= $c;
    } else {
      last;
    }
  }

  my $shoe = [];
  if ($str) {
    $shoe = deserialize_cookied_shoe( $str );
  }
  
  return $shoe;
}



#####################################################  split_shoe_cookies  ###
## Cookies can only be up to 2k.  Hopefully they're not that big,
## but we need to split things up if so. 
sub split_shoe_cookies {
  my ($big, $max_len) = @_;

  $max_len ||= 2000;
  my @substrs = $big =~ m|(.{1,$max_len})|g;

  my $i = 0;
  my @cookies = ();
  foreach my $c (@substrs) {
    push @cookies,
      $CGI->cookie(-name    => 's' . $i++,
                   -value   => $c,
                   -expires => '+3M' );
  }

  return \@cookies;
}



  
sub deserialize_cookied_shoe {
  my ($cookie) = @_;

  my $shoe = MIME::Base64::decode( $cookie );
  $shoe = Compress::Zlib::memGunzip( $shoe );
  $shoe = thaw( $shoe );

  return $shoe;
}


sub serialize_cookied_shoe {
  my ($shoe) = @_;

  my $cookie = freeze( $shoe );
  $cookie = Compress::Zlib::memGzip( $cookie );
  $cookie = MIME::Base64::encode( $cookie, '' );

  return $cookie;
}


##############################################################################
###            Shoe Functions
##############################################################################


##############################################################  dump_shoe  ###
## 
sub dump_shoe {

  my $shoe = &combine_shoe_cookies();

  print $CGI->header();
  print "<HR>\n";
  foreach my $c ($CGI->cookie()) {
    print "$c: ", $CGI->cookie( $c ), "<BR>\n";
  }
  print "<HR>\n";
  print "<pre>\n";
  print Dumper( $shoe );
  print "</pre>\n";

}


#############################################################  new_player  ###
## They don't have a deck, so we have to creae one.  We also
## know we need to send them them the first *two* hands instead
## of just one.
sub new_player {
  my $shoe = &load_shoe();

  die ("shoe too small!") unless (scalar @$shoe >= 2);
  
  ## Pick two random hands & swap them into the first spots
  my ($i, $j) = ( int(rand( scalar @$shoe )), int(rand( scalar @$shoe )) );
  while ($i == $j ) {
    ($i, $j) = ( int(rand( scalar @$shoe )), int(rand( scalar @$shoe )) );
  }
  ($shoe->[ $i ], $shoe->[ 0 ]) = ($shoe->[ 0 ], $shoe->[ $i ]);
  ($shoe->[ $j ], $shoe->[ 1 ]) = ($shoe->[ 1 ], $shoe->[ $j ]);

  return $shoe;
}


##############################################################  load_shoe  ###
## 
sub load_shoe {
  return retrieve( "$RULES_DIR/rules_strip_basic.str" ); 
}


############################################################  expand_hand  ###
## 
sub expand_hand {
  my ($c) = @_;

  
}

##########################################################  compress_hand  ###
## 
sub compress_hand {
  my ($p1, $p2, $d, $a) = @_;

  my $str = '';
  foreach my $i ($p1, $p2, $d, $a) {
    $str .= join("", ( split //, unpack("B*", pack("N", $i)))[ -4 .. -1 ]);
  }

  my $int = unpack("N", pack("B32", substr("0" x 32 . $str, -32)));
  print $int, "\n";
#  $str = chr( oct( "0b$str") + $ENCODE_OFFSET);
  
  return $str;
}





  


