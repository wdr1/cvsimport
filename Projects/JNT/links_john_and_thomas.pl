#!/usr/local/bin/perl -w

use strict;
use Template;
use Date::Calc qw|Today Add_Delta_YMD Month_to_Text Day_of_Week|;
use Data::Dumper;

our $DEST_TMPL =
  "http://www.ucomics.com/calvinandhobbes/[% y %]/[% m %]/[% d %]/";
our $IMG_TMPL =
  "http://images.ucomics.com/comics/ch/[% y %]/ch[% sy %][% m %][% d %].[% format %]";
our $DESC_TMPL =
  "Calvin and Hobbes for [% mt %] [% d %], [% y %]";
our $tt = Template->new({
                        INCLUDE_PATH => '/home/wdr1/Projects/JNT/',
                        });

our $EXTERNAL_LINK_FILE    = "/home/wdr1/Projects/JNT/links.txt";
our $RDF_TEMPLATE = "rdf2.tmpl";

## Test settings
#our $RDF_OUTPUT   = "/home/wdr1/public_html/hacking/ch-test.rdf";
## Production settings
our $RDF_OUTPUT   = "/home/wdr1/public_html/blog/calvin_and_hobbes.rdf";



## Set to days in the future we want to run.  E.g, 1 = tomorrow is today
our $DATE_SHIFT_BASE = 0;

&main();

sub main {
  my $h;

  my $links = &load_external_links( $EXTERNAL_LINK_FILE );
  
  my @items = map { &create_item( $_, $links ) } (0 .. 13);
  $tt->process($RDF_TEMPLATE, { 'items' => \@items }, $RDF_OUTPUT)
    || die( $tt->error() );
};


##############################################################  create_item  ###
## Based upon the offset (days from today), create the tuple needed to render 
## the item.
sub create_item {
  my ($offset, $links) = @_;
  
  my $h             = &format_date( $offset );
  my $external_link = &format_external_link( $h, $links );

  # jpg or gif?
  $h->{'format'} = $h->{'dow'} == 7 ? "jpg" : "gif"; 
 
  my ($DEST_URL, $IMG_URL, $DESCRIPTION);
  $tt->process(\$DEST_TMPL, $h, \$DEST_URL) || die( $tt->error() );
  $tt->process(\$IMG_TMPL, $h, \$IMG_URL) || die( $tt->error() );
  $tt->process(\$DESC_TMPL, $h, \$DESCRIPTION) || die( $tt->error() );
  
  return { 'link'          => $DEST_URL,
           'img'           => $IMG_URL,
           'title'         => $DESCRIPTION,
           'external_link' => $external_link,
         };
}


## -------------------------------------------------------  format_link  ---
## 
sub format_external_link {
  my ($h, $links) = @_;

  my $key  = join(".", $h->{'y'}, $h->{'m'}, $h->{'d'} );
  
  return  $links->{ $key } || "";
}


## --------------------------------------------------------  load_links  ---
## Load the link files
sub load_external_links {
  my ($link_file) = @_;

  my $h = {};
  
  open(LINK, $link_file) || die ($!);
  while (<LINK>) {
    my $line = $_;
    chomp( $line );
    my ($key, $val);
    ($key, $val) = $line =~ m|^\s*([^:]+)\s*:\s*(.+)\s*$|;
    $val =~ s|<|&lt;|g;
    $val =~ s|>|&gt;|g;
    $h->{ $key } = $val;
  }
  close(LINK) || warn($!);

  return $h;
}


###########################################################  format_date  ###
## Based upon the offset, figure out the various bits of the date.
sub format_date {
  my ($offset) = @_;
  my ($h, $sy, $mtext);

  $offset +=- $DATE_SHIFT_BASE;
  my ($year, $mon, $mday) = Add_Delta_YMD( Today(), 0, 0, -$offset);
  my $dow = Day_of_Week($year, $mon, $mday);
  $mon  = sprintf("%02d", $mon);
  $mday = sprintf("%02d", $mday); 
  ($sy = $year) =~ s/^\d\d//;      ## Short year (2 digit version)
  $mtext = Month_to_Text( $mon );
  
  $h = { 'y'   => $year,
         'sy'  => $sy,
         'm'   => $mon,
         'd'   => $mday,
         'mt'  => $mtext,
         'dow' => $dow,
       };
  
  return $h;
}


