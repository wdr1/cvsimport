#!/usr/local/bin/perl -w

## $Id: blackjack.cgi,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use strict;

use CGI;
use CGI::Carp qw|fatalsToBrowser|;
use Storable qw|retrieve freeze thaw|;
use Compress::Zlib;
use MIME::Base64;
use Data::Dumper;

use lib '.';
use Blackjack;

our %DISPATCH = (
                 'dump'   => \&Blackjack::dump_shoe,
                 'r'      => \&Blackjack::deal,          ## (r)ight
                 'noop'   => \&Blackjack::deal,          ## don't do anything
                 'w'      => \&Blackjack::deal,          ## (w)rong
                 'reset'  => \&Blackjack::reset_cookies,
);
  
our $action = $Blackjack::CGI->param('a');
$action ||= 'noop';

if (defined $DISPATCH{ $action }) {
  &{ $DISPATCH{ $action } }();
} else {
  die("I don't know what to do with '$action'!  Exiting...\n");
}

