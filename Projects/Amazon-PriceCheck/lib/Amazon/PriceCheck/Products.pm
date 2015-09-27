package Amazon::PriceCheck::Products;

# $Id: Products.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use 5.008008;
use strict;
use warnings;

use Carp 'cluck';
use Data::Dumper;

use Amazon::PriceCheck::Data;

require Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw(
  create_or_get_product
  load_product_list
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(
);

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10);
our $logger = get_pkg_logger();


sub load_product_list {
  my ($products) = @_;

  my $r = {};
  foreach my $product_email (@{ $products }) {
    my $product = &create_or_get_product( $product_email->{'product_name'},
                                          $product_email->{'category'},
                                          $product_email->{'price'} );

    if ($product) {
      $product->{'_PaidPrice'} = $product_email->{'price'};  ## Bad.
      push @{ $r->{'found'} }, $product;
    } else {
      push @{ $r->{'not_found'} }, $product_email;
    }
  }

  return $r;
}



## Try to find the ASIN in the DB.  If it doesn't exist, look it up
## on Amazon & add it
sub create_or_get_product {
  my ($product_name, $category, $price) = @_;
  $logger->trace( (caller(0))[3], " => ", Dumper( \@_ ) );

  my $product =
    $schema->resultset('Products')->find_or_new( { 'product_name' => $product_name,
                                                   'category'     => $category }
                                               );

  return $product if ($product->asin()); ## already exists

  my $asin = &find_asin_on_amazon( $product_name, $category, $price );
  unless ($asin) {
    $logger->warn("Coudn't find product in DB or Amazon '",
                  join("', '", @_), "'!  Skipping...");
    return undef;
  }

  $product->asin( $asin );
  $logger->info("Creating '$asin' for '", join("', '", @_), "'...");
  $product->insert();

  return $product;
}


sub find_asin_on_amazon {
  my ($name, $unmapped_category, $price) = @_;
  my (@strong_matches, @weak_matches);
  $logger->trace( (caller(0))[3], " => ", Dumper( \@_ ) );
  
  unless ($name) {
    cluck("No name parameter!") unless ($name);
    return;
  }

  my %search = ();
  my $key = 'title';
  $search{'title'} = $name;
  
  if ($unmapped_category) {
    my $category = $AP_PRODUCT_URL_MAP{ $unmapped_category };
    if ($category) { 
      $search{'mode'} = $category
    } else {
      $logger->warn("Unable to map '$unmapped_category' to a category!");
    }
  }

  unless ($search{'mode'}) {
    $key = 'blended';
  }

  my $amazon_agent = get_amazon_agent();
  $logger->debug( "Search => ", Dumper( \%search ) );
  my $response = $amazon_agent->search( %search );

  if($response->is_success()) {
    $logger->trace( " -- Success -- \n", $response->as_string(), "-- --\n" );
  } else {
    $logger->trace( (caller(0))[3], " => ", Dumper( \@_ ),
                    "Error: ", $response->message() );
  }

  $logger->debug( "Results: ", $response->total_results() );

  foreach my $p ($response->properties) {
    if ($p->ProductName() eq $name ) {
      if ($p->OurPrice() eq $price) {
        push @strong_matches, $p;
      } else {
        push @weak_matches, $p;
      }
    }
  }

  unless ( @strong_matches || @weak_matches ) {
    $logger->trace( "Unable to locate a match on Amazon for search: ",
                   Dumper( \%search ) );
  }

  my $results = { 'strong' => \@strong_matches,
                  'weak'   => \@weak_matches };
  $logger->trace( " -- Results -- \n", Dumper( $results ), "-- --\n" );

  ## TODO: Better support strong & weak, but for now just return one
  $results = (@strong_matches, @weak_matches, undef)[0];
  
  return $results ? $results->ASIN() : undef;
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!
