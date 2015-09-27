#!/usr/local/bin/perl -w

use strict;
use warnings;

use Data::Dumper;

use Amazon::PriceCheck::Users ':all';
use Amazon::PriceCheck::Products ':all';
use Amazon::PriceCheck::PurchasedProducts ':all';
use Amazon::PriceCheck::PriceCheck ':all';
use Amazon::PriceCheck::Data;

our $logger = get_pkg_logger();

&check_prices_on_these_products();
