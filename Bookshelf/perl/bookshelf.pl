#!/usr/local/bin/perl -w

## engine.cgi
##
## Created 10/9/02 -- William Reardon
##
## $Id: bookshelf.pl,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $
##
## The central engine tieing everything together.  Handles authorization,
## and dispatches each cgi query to the correct controller & correct view.
## 


use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use Cwd;

use lib 'Modules';
use Bookshelf::General;

our $VERSION = '$Revision: 1.1.1.1 $ ';

## Default view to fall on if none specified
our $DEFAULT_VIEW = 'dump';

our $c = new CGI;

&main($c);



sub main {
  my ($cgi) = @_;
  my ($controller, $view);

  ## Look up the function and view functions.
  {
    no warnings "uninitialized";
    $controller = $Bookshelf::Mapping{ $cgi->param( 'c' ) }{controller};
    $view       = $Bookshelf::Mapping{ ( $cgi->param( 'v' ) || $DEFAULT_VIEW ) }{view};
  }
  
  if ($view) {
    my $results = {};
    if ($controller) {
      $results = &$controller( $cgi );
    } 
    &$view( $cgi, $results );
  } else {
    die("ERROR: No view supplied!");
  }
  
}


