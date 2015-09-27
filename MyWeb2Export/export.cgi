#!/usr/local/bin/perl -w

## $Id: export.cgi,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

use strict;
use CGI;
#use CGI::Carp qw|fatalsToBrowser|;
use LWP::Simple;
use XML::Simple;

use Template;


use Data::Dumper;

our $YAHOO_URL = 'http://api.search.yahoo.com/MyWebService/V1/urlSearch?appid=MyWeb2Export&yahooid=__USER__&results=__BATCH_SIZE__&start=';
our $SLEEP      = 1;
our $BATCH_SIZE = 50;
our $MAX_LOOPS  = 3;
  
&main();

sub main {
  my $cgi  = new CGI;
  my $user = $cgi->param('user') || $cgi->param('u');
  die("No user given!\n") unless ($user);

  my $myweb_data = &fetch_myweb_data( $user );
  &deliciousify( $myweb_data );
  
  print $cgi->header();
  &output_delicious_format( $myweb_data );
}

sub output_delicious_format {
  my ($data) = @_;
  
  my $config = {
                INCLUDE_PATH => '.',
                PRE_CHOMP   => 1,
                POST_CHOMP   => 1,
                };
  my $template = Template->new( $config );
  $template->process( 'delicious.tt', { 'bookmarks' =>$data } );
}


## Clean up the data so that delicious likes it (fix spaces, etc.)
sub deliciousify {
  my ($data) = @_;

  foreach my $bookmark (@$data) {
    $bookmark->{'TagText'} =
      join(" ", map { s| |_|g; $_ } @{ $bookmark->{'Tags'}->{Tag} });
    if (ref($bookmark->{'Note'}) eq 'HASH' and ! %{ $bookmark->{'Note'} }) {
      $bookmark->{'Note'} = '';
    }
  }
}



sub fetch_myweb_data {
  my ($user) = @_;
  
  $YAHOO_URL =~ s/__USER__/$user/;
  $YAHOO_URL =~ s/__BATCH_SIZE__/$BATCH_SIZE/;

  my $start = 1;
  my $found = 0;
  my $total = 1;
  my $loop  = 0;

  my @results = ();

  ## Load their URLs
  while ($found < $total) {
    $loop++;
    last if ($loop >= $MAX_LOOPS);
    
    my $url = $YAHOO_URL . $start;
    my $xml = get( $url );
    my $data = XMLin( $xml,
                    ForceArray => [ 'Tag' ] );
  
    $total = $data->{'totalResultsAvailable'} || 1;
    $found += $data->{'totalResultsReturned'} || 1;

    push @results, @{ $data->{'Result'} };
    $start += $BATCH_SIZE;
  
    sleep 1;
  }

  return \@results;
}
