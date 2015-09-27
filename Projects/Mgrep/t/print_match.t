# $Id: print_match.t,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use Test::More qw|no_plan|;
use Mgrep;
use strict;

use Data::Dumper;

require test_helpers;

BEGIN { use_ok( 'Mgrep' ); }

my $cfg = Mgrep::parse_commandline('Event.pm', 't/mail/perl.small');
my $headers = slurp('t/mail/header.txt');

print Mgrep::format_match_header( $cfg );
print Mgrep::format_match( $cfg, $headers );

