## $Id: 00modules.t,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use Test::More qw|no_plan|;

BEGIN {
  use_ok( 'Mgrep' ); 
  use_ok( 'Mgrep::Parser' ); 
  use_ok( 'Mgrep::Config' ); 
  use_ok( 'Mgrep::Results' ); 
  use_ok( 'Mgrep::Matching' ); 
  use_ok( 'Mgrep::Parser::Mbox' ); 
}


