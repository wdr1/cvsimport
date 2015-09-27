#!/usr/local/bin/perl -w

use strict;
use warnings;

use Data::Dumper;

use Amazon::PriceCheck::Users ':all';
use Amazon::PriceCheck::Products ':all';
use Amazon::PriceCheck::PurchasedProducts ':all';
use Amazon::PriceCheck::EmailParser ':all';
use Amazon::PriceCheck::EmailSend ':all';
use Amazon::PriceCheck::EmailPop;
use Amazon::PriceCheck::Data;

our $logger = get_pkg_logger();

my $mailbox = Amazon::PriceCheck::EmailPop->new();
$mailbox->init();
my ($msg, @products_not_found);
while ($msg = $mailbox->next_message()) {
  my $purchase = parse_email( $msg );

  my $user = &create_or_get_user( $purchase->{'email'} );
  my $product_results = &load_product_list( $purchase->{'products'} );

  if ($product_results->{'not_found'}) {
    ## For analysis later
    Log::Log4perl::get_logger('parsing')->warn("Unable to find all products in email!  ",
                                               scalar @{ $product_results->{'not_found'} },
                                               " found.\n",
                                               $msg,
                                               Dumper($product_results->{'not_found'}),
                                               "=" x 78, 
                                              );
  }

  &record_purchase_list( $user->id(),
                         $product_results->{'found'} );

  &send_post_load_notification( $user, $product_results );
}

