package Wikify;

## $Id: Wikify.pm,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

use strict;
use DB_File;
require Exporter;

our @ISA = qw|Exporter|;
our @EXPORT_OK = qw|wikify_text|;

our $WIKI_BASE = 'http://en.wikipedia.org/wiki/';
our $MAX_SPAN  = 8;
our $WIKI_DB = 'wikify.db';
our $SKIP_DB = 'skip.db';
our $MIN_WORD_LENGTH = 2;

our $initialized = 0;
our (%terms, %skip);

#############################################################  initialize  ###
## 
sub initialize {
  tie %skip,  "DB_File", $SKIP_DB, O_RDWR, 0666, $DB_HASH or die($!);
  print STDERR scalar keys %skip, " skip terms.\n";
  tie %terms, "DB_File", $WIKI_DB, O_RDWR, 0666, $DB_HASH or die($!);
  # %terms = ('mutiny on the bounty' => 'mutiny on the bounty',
  #           'a.w.o.l.' => 'A.W.O.L.');
  print STDERR scalar keys %terms, " wiki terms.\n";
  
  ## Things we should skip
  $terms{ "'s" } = 1;
  
  $initialized = 1;

  return 1;
}


############################################################  wikify_line  ###
## 
sub wikify_text {
  my ($text) = @_;

  &initialize() unless ($initialized);

  my %wiki_terms = ();
  my $output = "";
  
  foreach my $line (split /\n/, $text) {
    chomp($line);
  
    my @tokens = split /\b/, $line;

    ## Traverse the string, left to right
    for ( my $win_start = 0; $win_start <= $#tokens; $win_start++) {
      unless ($tokens[ $win_start ] =~ /\S/) {
        $output .= $tokens[ $win_start ];
        next;
      }

      my $insert_phrase = $tokens[ $win_start];
      ## Start the window at the longest length, then bring it in, step by step
      for (my $win_len = $MAX_SPAN; $win_len >= 0; $win_len--) {
        ## Windows too long, or end w/ white space on the end
        next if ($win_start + $win_len > $#tokens);
        next unless ($tokens[ $win_start + $win_len] =~ /\S/);

        ## Reassemble our window
        my $str = join("", @tokens[ $win_start .. $win_start + $win_len ]);
        ## Normalize the phrase
        my $lc_str = lc( $str );
        #      print "Checking '$str' ($win_start .. $win_len)\n";
      
        ## Skip skip terms
        next if (  &skip_term_exists( $lc_str ) );
        ## Is this a WikiWord?
        my $wiki_str = &get_wiki_term( $lc_str );
        if ( $wiki_str ) {
#          print "WikiWord: $str -> $wiki_str\n";
          ## Skip ahead to the end of this word & break out of inner loop
          $win_start += $win_len;
          $win_len = 0;
          unless ($wiki_terms{ $wiki_str }) {
            $insert_phrase = "<A HREF='${WIKI_BASE}${wiki_str}'>$str</A>";
          } else {
            $insert_phrase = "$str";
          }
          $wiki_terms{ $str }++;
        }
      }

      $output .= $insert_phrase;
    }
    $output .= "\n";
  }

  return ($output, \%wiki_terms);
}


#######################################################  skip_term_exists  ###
## 
sub skip_term_exists {
  my ($term) = @_;

  return exists( $skip{ $term });
}


#######################################################  wiki_term_exists  ###
## 
sub get_wiki_term {
  my ($term) = @_;

  return if (length( $term ) < $MIN_WORD_LENGTH);
  return $terms{ $term };
}


####################################################################  min  ###
## 
sub min {
  my ($x, $y) = @_;

  return $x < $y ? $x : $y;
}

1;
