# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Amazon-PriceCheck.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 2;
BEGIN { use_ok('Amazon::PriceCheck::EmailPop') };

## Our test settings...
%AMAZON::PRICECHECK::DATA::MAILBOX =
  ( 'username' => 'amazon-test+wdr1.com',
    'password' => '<password>',
    'host'     => 'mail.wdr1.com',
  );



my $mailbox = Amazon::PriceCheck::EmailPop->new();
$mailbox->init();
my $msg;
while ($msg = $mailbox->next_message()) {
  print "=" x 78, "\n";
  print join("",@$msg);
}

ok(1);

