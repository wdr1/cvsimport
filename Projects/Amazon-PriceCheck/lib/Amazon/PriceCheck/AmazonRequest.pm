package Amazon::PriceCheck::AmazonRequest;

#Id: $

use 5.008008;
use strict;
use warnings;

use DBI;
use Net::Amazon;
use Log::Log4perl;

use Amazon::PriceCheck::Data;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(
);

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10);
our $logger = get_pkg_logger();

sub find_asin_on_amazon {
  my ($product_name, $category, $price) = @_;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!
