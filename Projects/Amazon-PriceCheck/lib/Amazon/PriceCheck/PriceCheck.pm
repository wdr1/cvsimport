package Amazon::PriceCheck::PriceCheck;

# $Id: PriceCheck.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use 5.008008;
use strict;
use warnings;

use Net::Amazon;
use Data::Dumper;

use Amazon::PriceCheck::Data;

require Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw(
  check_prices_on_these_products
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(
);


our $VERSION = substr(qw$Revision: 1.1.1.1 $, 10);


our $logger = get_pkg_logger();

sub check_prices_on_these_products {
  my $rs = $schema->resultset('Products')->search(
   {
    'usersxproducts.crt_ts' => \'<= now()',  #' cperl gets angry at one quote
   },
   {
    'distinct' => 1,
    'join'     => 'usersxproducts',
    'order_by' => 'crt_ts',
   },
                                                  );

  my @asins = ();
  while (my $row = $rs->next()) {
    push @asins, $row->asin();
  }
  $logger->info(scalar @asins, " asins to lookup...");

  my $ua = get_amazon_agent();
  while (@asins) {
    my (@lookup) = splice(@asins, 0, $MAX_ASINS_PER_REQUEST);

    $logger->info("Looking up ", join(", ", @lookup), "...");
    my $response = $ua->search('asin' => \@lookup);
    unless($response->is_success()) {
      $logger->error( "Unable to lookup ASINs: '", 
                      join(", ", @lookup), ":",
                      $response->message(), "\n" );
      next;
    }

    foreach my $p ($response->properties) {
      my $price = $p->OurPrice();
      $price =~ s|^\$||;
      $logger->debug("Updating ASIN price: ", $p->ASIN(), " to $price");
      my $rs = $schema->resultset('Products')->search({'asin' => $p->ASIN()});
      $rs->update( { 'last_seen_price' => $price,
                     'last_seen_date'  => \ 'now()' } );
    }
  }
}



1;
__END__
# Below is stub documentation for your module. You'd better edit it!
