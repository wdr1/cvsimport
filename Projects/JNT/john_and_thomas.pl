#!/usr/local/bin/perl -w

use strict;
use Template;
use Date::Calc qw|Today Add_Delta_YMD Month_to_Text|;
use Data::Dumper;

our $DEST_TMPL =
  "http://www.ucomics.com/calvinandhobbes/[% y %]/[% m %]/[% d %]/";
our $IMG_TMPL =
  "http://images.ucomics.com/comics/ch/[% y %]/ch[% sy %][% m %][% d %].gif";
our $DESC_TMPL =
  "Calvin and Hobbes for [% mt %] [% d %], [% y %]";
our $tt = Template->new({
                        INCLUDE_PATH => '/home/wdr1/Projects/JNT/',
                        });

our $RDF_TEMPLATE = "rdf.tmpl";
our $RDF_OUTPUT   = "/home/wdr1/public_html/blog/calvin_and_hobbes.rdf";

&main();

sub main {
  my $h;

  my @items = map { &create_item( $_ ) } (0 .. 13);
  $tt->process($RDF_TEMPLATE, { 'items' => \@items }, $RDF_OUTPUT)
    || die( $tt->error() );
};

##############################################################  create_item  ###
## Based upon the offset (days from today), create the tuple needed to render 
## the item.
sub create_item {
  my ($offset) = @_;
  
  my $h = &format_date( $offset );

  my ($DEST_URL, $IMG_URL, $DESCRIPTION);
  $tt->process(\$DEST_TMPL, $h, \$DEST_URL) || die( $tt->error() );
  $tt->process(\$IMG_TMPL, $h, \$IMG_URL) || die( $tt->error() );
  $tt->process(\$DESC_TMPL, $h, \$DESCRIPTION) || die( $tt->error() );
  
  return { 'link'  => $DEST_URL,
           'img'   => $IMG_URL,
           'title' =>$DESCRIPTION };
}




###########################################################  format_date  ###
## Based upon the offset, figure out the various bits of the date.
sub format_date {
  my ($offset) = @_;
  my ($h, $sy, $mtext);

  my ($year, $mon, $mday) = Add_Delta_YMD( Today(), 0, 0, -$offset);
  $mon  = sprintf("%02d", $mon);
  $mday = sprintf("%02d", $mday); 
  ($sy = $year) =~ s/^\d\d//;      ## Short year (2 digit version)
  $mtext = Month_to_Text( $mon );
  
  $h = { 'y'  => $year,
         'sy' => $sy,
         'm'  => $mon,
         'd'  => $mday,
         'mt' => $mtext,
       };
  
  return $h;
}


