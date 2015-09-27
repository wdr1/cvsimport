#!/usr/local/bin/perl -w

use strict;
use Debug;

## CGI for running Linkblog.  (I still like the blink name better)
##
## $Id: linkblog.pl,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $
##

use lib '.';

use Linkblog;
use Log::Log4perl;

## Debugging settings
use CGI::Carp qw(fatalsToBrowser);
$Debug::DEBUG_LEVEL = 1;

Log::Log4perl->init("conf/logger.conf");
my $webapp = Linkblog->new();
$webapp->run();

