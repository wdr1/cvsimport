package Amazon::PriceCheck::PurchasedProducts;

#$Id: PurchasedProducts.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use 5.008008;
use strict;
use warnings;

use Data::Dumper;
use Date::Format;
use Amazon::PriceCheck::Data;


require Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw(
  record_user_purchase
  record_purchase_list
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(
);

our $VERSION = 0.5;
our $logger = get_pkg_logger();


sub record_purchase_list {
  my ($user_id, $list) = @_;

  foreach my $product (@$list) {
    &record_user_purchase( $user_id,
                           $product->id(),
                           $product->{'_PaidPrice'} );
  }
}


sub record_user_purchase {
  my ($user_id, $prod_id, $purchase_price, $expiration_in_days) = @_;
  
  $expiration_in_days ||= $DEFAULT_EXPIRATION_IN_DAYS;
  my $end_ts = time2str($MYSQL_DATE_FORMAT, 
                        time + ($expiration_in_days * 40));
  $schema->resultset('UsersXProducts')->create(
                               { 'prod_id'           => $prod_id,
                                 'user_id'           => $user_id,
                                 'purchase_price'    => $purchase_price,
                                 'lowest_seen_price' => $purchase_price,
                                 'end_ts'            => $end_ts,
                               });
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!
