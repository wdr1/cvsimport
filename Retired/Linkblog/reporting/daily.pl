#!/usr/local/bin/perl -w

use strict;
use Getopt::Long;
use Data::Dumper;

use lib '/home/wdr1/Sandboxes/wdr1/Linkblog';
use Linkblog::DB;

our $dbh;

&main();

###################################################################  main  ###
## 
sub main {
  &init();
  my $h = &tally_up();
  my $text = &generate_report( $h );

  print $text;
}

###########################################################  print_report  ###
## 
sub generate_report {
  my ($h) = @_;
  my ($text);

  my $now = scalar localtime;
$text=<<"__TEXT__";
Linkblog summary report for $now

Total Users: $h->{users_total}
New Users:   $h->{users_recent}

Total Links: $h->{links_total}
New Link:    $h->{links_recent}
__TEXT__

  return $text;
}


###################################################################  init  ###
## 
sub init {
  $dbh = Linkblog::DB::_init_db_handle();

}


###############################################################  tally_up  ###
## 
sub tally_up {
  my (%h);
  
  ## User counts
  $h{'users_total'}  = &count_users_since( 10000 );
  $h{'users_recent'} = &count_users_since( 1 );

  ## Link counts
  $h{'links_total'}  = &count_links_since( 10000 );
  $h{'links_recent'} = &count_links_since( 1 );

  return \%h;
}


############################################################  count_users  ###
## 
sub count_users_since {
  my ($days) = @_;

  $days ||= '10000';

  my $sql=<<"__SQL__";
SELECT count(1)
  FROM auth_user
 WHERE DATE_SUB(CURDATE(),INTERVAL $days DAY) <= au_crt_ts
__SQL__

  my ($count) = $dbh->selectrow_array( $sql );

  return $count;
}


############################################################  count_links  ###
## 
sub count_links_since {
  my ($days) = @_;

  $days ||= '10000';
  
  my $sql=<<"__SQL__";
SELECT count(1)
  FROM links
 WHERE DATE_SUB(CURDATE(),INTERVAL $days DAY) <= lk_crt_ts
__SQL__

  my ($count) = $dbh->selectrow_array( $sql );

  return $count;
}






