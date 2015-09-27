# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Blackjack-SharedShoe.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More 'no_plan';

use Data::Dumper;
use Storable;

use_ok('Blackjack::Config');
use_ok('Blackjack::PristineShoe');

my $c = new Blackjack::Config;

system("rm -Rf /tmp/trainer");
my ($ps, $data);


$ps = new Blackjack::PristineShoe( 'config' => $c );
$data = $ps->load_pristine_shoe('simple');
#store( $data, 't/support/simple_expected.stor' );
my $expected = retrieve( 't/support/simple_expected.stor' );
is_deeply( $data, $expected, "simple shoe");
is( $data->{weight}, 64, "weight");

is( $data->{fields}{incorrect_response_weight}, 2,
    "incorrect_response_weight accessor" );


#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

