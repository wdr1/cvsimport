use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'AmazonPriceCheck' }
BEGIN { use_ok 'AmazonPriceCheck::Controller::Guid' }

ok( request('/guid')->is_success, 'Request should succeed' );


