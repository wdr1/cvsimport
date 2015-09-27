#!/usr/local/bin/perl -w

use strict;
use Getopt::Long;
use Data::Dumper;
use Template;

use lib '/home/wdr1/Sandboxes/wdr1/Linkblog';
use Linkblog;
use Linkblog::DB;

our $dbh;
our $VERSION = '$Revision: 1.1.1.1 $ ';
our $POPULAR_HTML =
  '/home/sites/linkblog.org/public_html/static/popular_links.html';
our $RECENT_HTML =
  '/home/sites/linkblog.org/public_html/static/recent_links.html';

&main();

###################################################################  main  ###
## 
sub main {
  my $cfg = &init();
  
  if ($cfg->{popular}) {
    my $links = &get_most_popular_links( $cfg->{max_count} );
    &output_links( $links, 
                   $POPULAR_HTML
                 );
  }
  
  if ($cfg->{recent}) {
    my $links = &get_recent_links( $cfg->{max_count} );
    &output_links( $links,
                   $RECENT_HTML
                 );
  }
}


#################################################  get_most_popular_links  ###
## 
sub get_most_popular_links {
  my ($count) = @_;

  my $sql=<<"__SQL__";
SELECT l.lk_url as url,
       MAX(l.lk_title) as title,
       COUNT(1) as tally,
       MAX(l.lk_crt_ts) as last_mod
  FROM links l, auth_user u
 WHERE l.au_id = u.au_id
   AND u.au_public_flag = 'T'
   AND DATE_SUB(CURDATE(),INTERVAL 1 DAY) <= l.lk_crt_ts
 GROUP BY l.lk_url
 ORDER BY tally DESC, last_mod DESC
 LIMIT $count
__SQL__
  
  my $rows = $dbh->selectall_arrayref( $sql );

  return $rows;
}


#################################################  get_most_recent_links  ###
## 
sub get_recent_links {
  my ($count) = @_;

  my $sql=<<"__SQL__";
SELECT DISTINCT l.lk_url as url,
       l.lk_title as title
  FROM links l, auth_user u
 WHERE l.au_id = u.au_id
   AND u.au_public_flag = 'T'
   AND DATE_SUB(CURDATE(),INTERVAL 1 DAY) <= l.lk_crt_ts
 ORDER BY l.lk_crt_ts DESC
 LIMIT $count
__SQL__
  
  my $rows = $dbh->selectall_arrayref( $sql );

  return $rows;
}


###########################################################  output_links  ###
## 
sub output_links {
  my ($links, $f) = @_;

  my $h = {
           'links' => $links,
           };

  my $t = new Template( $Linkblog::TT_CONFIG );
  $t->process( 'batch_list_links.tt', $h, $f )
    || die ($t->error() );

}


###################################################################  init  ###
## 
sub init {
  my ($cfg);
  my ($help, $version);
  
  $dbh = Linkblog::DB::_init_db_handle();
  

    my $usage=<<"__USAGE__";
$0 --user=<user> --password=<password> [--help] [--version]
           [--siggen=(karma|uptime|quote|rating|karating)]
           [--no-star] [--baseurl=site]

--help        - show this screen
--version     - show the version

--popular     - generate the most 'popular links' page
--recent      - generate the 'recent links' page
--all         - generate both recent & popular [default]  
--max-count   - max number of links to generate  
__USAGE__

  $cfg = {};
  GetOptions($cfg, "help!", "version!", "user=s", "debug+",
             "popular!", "recent!", "all!", 'max-count=i'
            ) || die($usage);

  ## Version & Help
  if ($cfg->{version}) {
    print "$0 -- $VERSION\n";
    exit(0);
  }
  if ($cfg->{help}) {
    print $usage;
    exit(0);
  }

  ## Set the default 'all' (can also be set via cli)
  unless( $cfg->{'popular'} || $cfg->{'recent'} ) {
    $cfg->{'all'} = 1;
  }

  ## Expand --all
  if ($cfg->{all}) {
    $cfg->{'popular'} = 1;
    $cfg->{'recent'} = 1;
  }

  $cfg->{max_count} = $cfg->{'max-count'} || 10;

  return $cfg;
}


