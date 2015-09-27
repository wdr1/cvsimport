#!/usr/local/bin/perl -w

## $Id: pull_new_listings.pl,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use strict;
use IO::All;
use HTML::TreeBuilder 3;
use Data::Dumper;
use LWP::Simple;
use Storable;
use Date::Calc qw|Today_and_Now|;
$| = 1;

my %areas = (
             'altadena' => 604,
             'atwater'  => 606,
             'burbank'  => 610,
             'eagle rock' => 618,
             'glendale - chevychase' => 624,
             'glendate - northwest'  => 626,
             'rossmyn & verdugo woodlnd' => 627,
             'glendate - south of 134' => 628,
             'lacanada/flintridge' => 634,
             'pasadena (nw)' => 645, 
             'pasadena (ne)' => 646, 
             'pasadena (sw)' => 647, 
             'pasadena (se)' => 648, 
             'silverlake'    => 671,
             );

my @mls_keys = (
                'address',
                'cost',
                'sqft',
                'lot',
                'beds',
                'bath',
                'bath detail',
                'type',
                'listing',
                'area',
                'area num',
                'cost group',
                'year',
                'added',
                'link',
               );

&main();

sub main {
  my %results = ();
  foreach my $area (keys %areas) {
    my $c = get_search_results( $areas{ $area } );
#    my $c < io( 'results.html' );
    my $r = parse_page( $c, $area, $areas{ $area } );
    %results = (%results, %$r);
    sleep 1;   ## be polite
  }

  my $r = blend_old_results( \%results );
  &output_results( $r );
}


sub output_results {
  my ($r) = @_;
  
  my $output = join("\t", @mls_keys) . "\n";
  foreach my $listing (sort keys %$r) {
    $output .= join("\t", map { $r->{ $listing }{ $_ } } @mls_keys). "\n";
  }

  $output > io("mls_listings.txt");    
}


sub blend_old_results {
  my ($r) = @_;

  my $file = "mls_listings.stor";
  my $old = {};
  if (-e $file) {
    $old = retrieve( $file );
  }
  foreach my $l (keys %$r) {
    unless (exists $old->{ $l }) {
      print "Adding listing '$l' - ", $r->{ $l }{'address'},
        " (", $r->{ $l }{'cost'}, ")\n";
      print "\t", $r->{ $l }{'link'}, "\n";
      my ($year, $month, $day, $hour) = Today_and_Now();
      $r->{ $l }{ 'added' } = join("/", $month, $day, $year ). " $hour:00";
      $old->{ $l } = $r->{ $l };
    }
  }
  $r = $old;

  store $r, $file;

  return $r;
}
  
sub parse_page {
  my ($content, $area, $area_num) = @_;

  $content > io('out.txt');

  my $root = HTML::TreeBuilder->new;
  $root->parse( $content );
  $root->eof( );
  
  my $results = {};

  ## Find the "main" table
  my @path = (1, 0, 4, 0, 0, 1, 0, 9);
  my $node = $root;
  foreach my $i (@path) {
    $node = ($node->content_list)[ $i ];
  }
  my @nodes = $node->content_list;

  ## Clean up some cruft that can trip us up
  shift @nodes; shift @nodes;
  my $i = 0;
  while ($i <= $#nodes) {
    if ($nodes[ $i ]->as_text !~ /\w/ ||
        $nodes[ $i ]->as_text =~ /FTHQ/ ) {
      splice(@nodes, $i, 1);
      next;
    }
    $i++;
  }

  while (@nodes) {
    my ($node_cost, $node_desc, $node_mls) =
      (shift @nodes, shift @nodes, shift @nodes);
    my %h = ( 'area' => $area, 'area num' => $area_num );

    ## Cost Node
    ($h{'cost'}, $h{'beds'}, $h{'bath'}, $h{'sqft'}, $h{'lot'},
     $h{'year'}, $h{'type'}) =
       map { $_->as_text } 
         ( $node_cost->find_by_tag_name('td') );
    $h{'lot'} =~ s/^([0-9,]+).*/$1/;
    ($h{'bath'}, $h{'bath detail'}) = $h{'bath'} =~ /^(\d)\s*(.*)/;
    my $cost = $h{'cost'};
    $cost =~ s/\D//g;
    $h{'cost group'} = int($cost/100000) * 100000;
  
    ## Desc Node
    my $node_addr = $node_desc->find_by_attribute('class', 'mBlackTextB');
    $h{'address'} =
      join(" ", map { $_->as_text() } $node_addr->find_by_tag_name('td') );
    $h{'address'} =~ s/\xA0/ /g;

    ## mls listing node
    ($h{'listing'}) = $node_mls->as_text() =~ m|Listing #(\d+)|;
    foreach my $n ($node_mls->find_by_tag_name('a')) {
      if ($n->as_text() eq "View Details") {
        $h{'link'} = 'http://itech.rapmls.com' . $n->attr('href');
      }
    }

#     print "=" x 78, "\n";
#     print "Address: ", $h{'address'}, "\n";
#     print "-" x 78, "\n";
#     print $node_cost->as_text(), "\n";
#     print "-" x 78, "\n";
#     print $node_desc->as_text(),"\n";
#     print "-" x 78, "\n";
#     print $node_mls->as_text(),"\n";
    
   $results->{ $h{'listing'} } = \%h;
  }

  $root->delete;
  print scalar keys %$results, " found in '$area'.\n";

  return $results;
}


sub get_search_results {
  my ($num) = @_;

  my $url = 'http://itech.rapmls.com/scripts/mgrqispi.dll?APPNAME=Itech&PRGNAME=MLSSearchSaveCriteria&ARGUMENTS=-N783625745%2C-N3426033%2C-APB%2C-N0&SubmitInProcess=Yes&IsPublic=Y&IsFranchise=N&Submit_Value=&submit=Submit&Prop_Count=8&Single_PT_Selected=&Prop_Types_String=RESI%2CRESL%2CMOBL%2CLOTL%2CRSIN%2CCOMM%2CCMLS%2CBUSO&Prop_Types_Amenity_String=Y%2CY%2CY%2CY%2CY%2CY%2CY%2CY&Prop_Types_Auction_String=&Prop_Types_Measurement_String=E%2CE%2CE%2CE%2CE%2CE%2CE%2CE&PT_Measurement_Default_String=A%2CA%2CA%2CA%2CA%2CA%2CA%2CA&Prop_Type_RESI=on&Prop_Subtype_Count_RESI=9&Prop_Subtype_Count_RESL=9&Prop_Subtype_Count_MOBL=1&Prop_Subtype_Count_LOTL=1&Prop_Subtype_Count_RSIN=2&Prop_Subtype_Count_COMM=2&Prop_Subtype_Count_CMLS=10&Prop_Subtype_Count_BUSO=1&Prop_Subtype_RESI_0001=on&Prop_Subtype_RESI_0001_X=RESD&Prop_Subtype_RESI_0002_X=RESI&Prop_Subtype_RESI_0003_X=CNDD&Prop_Subtype_RESI_0004_X=COND&Prop_Subtype_RESI_0005=on&Prop_Subtype_RESI_0005_X=TOWN&Prop_Subtype_RESI_0006_X=LOFT&Prop_Subtype_RESI_0007_X=OWNY&Prop_Subtype_RESI_0008_X=STOK&Prop_Subtype_RESI_0009_X=PUDD&Prop_Subtype_RESL_0001_X=RESD&Prop_Subtype_RESL_0002_X=RESI&Prop_Subtype_RESL_0003_X=CNDD&Prop_Subtype_RESL_0004_X=COND&Prop_Subtype_RESL_0005_X=APRT&Prop_Subtype_RESL_0006_X=TOWN&Prop_Subtype_RESL_0007_X=LOFT&Prop_Subtype_RESL_0008_X=OWNY&Prop_Subtype_RESL_0009_X=STOK&Prop_Subtype_RSIN_0001_X=RSIN&Prop_Subtype_RSIN_0002_X=LOFT&Prop_Subtype_COMM_0001_X=COMM&Prop_Subtype_COMM_0002_X=INDR&Prop_Subtype_CMLS_0001_X=HMFG&Prop_Subtype_CMLS_0002_X=INDS&Prop_Subtype_CMLS_0003_X=LTMF&Prop_Subtype_CMLS_0004_X=MIXU&Prop_Subtype_CMLS_0005_X=OFFC&Prop_Subtype_CMLS_0006_X=RECR&Prop_Subtype_CMLS_0007_X=RSTR&Prop_Subtype_CMLS_0008_X=RETL&Prop_Subtype_CMLS_0009_X=WRHS&Prop_Subtype_CMLS_0010_X=OTHR&Street_Number_From_1=&Street_Number_From_2=&Street_Number_From_3=&Street_Number_From_4=&Street_Number_From_5=&Street_Number_From_6=&Street_Number_From_7=&Street_Number_From_8=&Street_Number_From_9=&Street_Number_From_10=&Street_Number_Thru_1=&Street_Number_Thru_2=&Street_Number_Thru_3=&Street_Number_Thru_4=&Street_Number_Thru_5=&Street_Number_Thru_6=&Street_Number_Thru_7=&Street_Number_Thru_8=&Street_Number_Thru_9=&Street_Number_Thru_10=&Street_Direction_1=&Street_Direction_2=&Street_Direction_3=&Street_Direction_4=&Street_Direction_5=&Street_Direction_6=&Street_Direction_7=&Street_Direction_8=&Street_Direction_9=&Street_Direction_10=&Street_Address_1=&Use_Exact_1=begins&Street_Address_2=&Use_Exact_2=begins&Street_Address_3=&Use_Exact_3=begins&Street_Address_4=&Use_Exact_4=begins&Street_Address_5=&Use_Exact_5=begins&Street_Address_6=&Use_Exact_6=begins&Street_Address_7=&Use_Exact_7=begins&Street_Address_8=&Use_Exact_8=begins&Street_Address_9=&Use_Exact_9=begins&Street_Address_10=&Use_Exact_10=begins&Street_Suffix_1=&Street_Suffix_2=&Street_Suffix_3=&Street_Suffix_4=&Street_Suffix_5=&Street_Suffix_6=&Street_Suffix_7=&Street_Suffix_8=&Street_Suffix_9=&Street_Suffix_10=&Post_Direction_1=&Post_Direction_2=&Post_Direction_3=&Post_Direction_4=&Post_Direction_5=&Post_Direction_6=&Post_Direction_7=&Post_Direction_8=&Post_Direction_9=&Post_Direction_10=&Unit_Number_1=&Unit_Number_2=&Unit_Number_3=&Unit_Number_4=&Unit_Number_5=&Unit_Number_6=&Unit_Number_7=&Unit_Number_8=&Unit_Number_9=&Unit_Number_10=&IsRegion=N&RegionLabel=&RegionText=Click+the+Select++button+for+selections.&AreaText=Click+the+Select+Areas+button+for+selections.&AreaText2=Select+one++before+selecting+Areas.&Regions_PB=&AreaLabel=Area&Region_Fill_In_5=&Area_Fill_In_5=&Region_Fill_In_6=&Area_Fill_In_6=&Region_Fill_In_7=&Area_Fill_In_7=&Region_Fill_In_8=&Area_Fill_In_8=&Region_Fill_In_9=&Area_Fill_In_9=&Enforce_Area_To_City=N&Price_From_M1=300&Price_From_M2=000&Price_Thru_M1=800&Price_Thru_M2=000&Year_Built_From=&Year_Built_Thru=&Bedrooms_From=2+&Bedrooms_Thru=+&Bathrooms_From=+&Bathrooms_Thru=+&Bathrooms_From_F=+&Bathrooms_Thru_F=+&Bathrooms_From_H=+&Bathrooms_Thru_H=+&Bathrooms_From_T=+&Bathrooms_Thru_T=+&Bathrooms_From_Q=+&Bathrooms_Thru_Q=+&Structure_Square_Feet_From=&Structure_Square_Feet_Thru=&Lot_Size_From=&Lot_Size_Thru=&Lot_Measurement=A&Areas_PB=' . $num;

  my $content = get( $url );

  return $content;
}
