#!/usr/local/bin/perl -w

use strict;

use JSON;
use CGI;
use Data::Dumper;

my @list = ();

my $i = 4;
my $cgi = new CGI;
my $i = $cgi->param('c') || 4;

my $prefix = (localtime(time))[0] . (localtime(time))[1];
while ($i--) {
  push @list, join("-", $prefix, int(rand(9999999)));
}

print CGI::header( -content_type => "application/json; charset=utf-8" );
print objToJson( { "randomNumbers" => \@list } ), "\n";
#print objToJson(  \@list  ), "\n";
