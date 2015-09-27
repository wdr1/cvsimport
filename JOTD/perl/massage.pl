#!/usr/local/bin/perl -w

use strict;
use Data::Dumper;

## $Id: massage.pl,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $
##
## Created 7/10/04 -- William Reardon

## I gave up trying to parse the XML Docbook for now.  In the mean-time,
## we'll use the HTML.  To do so, we need two things:
##
## 1) A list of all the terms
## 2) Massaged versions of the html that have the links
##    w/ absolute paths, making them appropiate for both the
##    web & email.
##
## (Hopefully, I can circle back & get this working w/ Docbook,
##  but at this moment jargsrc.tar.gz distribution I think is broken.)


## Where does the HTML tarbar live -- the source of truth for us
our $HTML_SRC = "/home/wdr1/Sandboxes/wdr1/JOTD/jargon-4.4.7/html"; 
## What's the master file we'll crawl from to get all the terms
our $HTML_START = "/home/wdr1/Sandboxes/wdr1/JOTD/jargon-4.4.7/html/letters.html";
## Where to output everything
our $HTML_DEST = "../html";
## Where to output a list of all entries
our $ENTERY_LIST = "../html/term_list.txt";

&main();

sub main {
  my $terms = &generate_term_list();
  exit(0);
  &write_term_list( $terms );
}

#####################################################  generate_term_list  ###
## Given the file that lists the letters, figure out the additional
## files we have to crawl, and crawl them, resulting in a full term
## list at the end.
sub generate_term_list {
  my ($start, $src) = @_;

  $start ||= $HTML_START;
  $src   ||= $HTML_SRC;

  die("\$HTML_START of '$HTML_START' either doesn't exist or isn't a file!")
    unless (-f $HTML_START);
  die("\$HTML_SRC of '$HTML_SRC' either doesn't exist or isn't a directory!")
    unless (-d $HTML_SRC);

  my @files = (); ## more than A .. Z as numbers, etc can be included
  open(F, $start) || die("Couldn't read '$start': $!");
  @files = map { "$src/$_" }
    map { /href="([^\"]+\-frame.html)"/sg } <F>;

  my %terms;
  foreach my $f (@files) {
    open(F, $f) || die("Couldn't read file '$f': $!");
    my $text = join("", <F>);
    while ($text =~ m|href="([^\"]+.html)">([^<]+)</a|g) {
      $terms{ $2 } = $1;
    }
  }

}


