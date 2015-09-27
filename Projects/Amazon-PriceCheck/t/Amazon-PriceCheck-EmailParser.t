# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Amazon-PriceCheck.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 2;
BEGIN { use_ok('Amazon::PriceCheck::EmailParser') };

Amazon::PriceCheck::EmailParser::item_parse(1, 2);

ok(1);

