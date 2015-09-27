package Amazon::PriceCheck::Data;

# $Id: Data.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use 5.008008;
use strict;
use warnings;

use DBI;
use Net::Amazon;
use Log::Log4perl;
use Template;

use Amazon::PriceCheck::Schema;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Amazon::PriceCheck ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
  %AP_PRODUCT_URL_MAP	get_pkg_logger get_amazon_agent $dbh $schema
  $DEFAULT_EXPIRATION_IN_DAYS $MYSQL_DATE_FORMAT $MAX_ASINS_PER_REQUEST
  $POST_LOAD_NOTIFICATION_TEMPLATE $SENDMAIL get_template_toolkit_object
  %URL
);

our $VERSION = do { my @r = ( q$Revision: 1.1.1.1 $ =~ /\d+/g ); sprintf "%d." . "%02d" x $#r, @r };

our $AMAZON_TOKEN = '11G70YTMY40RSQGHHZR2';

my $log_conf = q/
#  log4perl.category = WARN, Logfile, Screen
#  log4perl.category = FATAL, Screen
  log4perl.logger.Amazon = WARN, Logfile, Screen
  log4perl.logger.parsing = INFO, ParsingAppender

  log4perl.appender.Logfile = Log::Log4perl::Appender::File
  log4perl.appender.Logfile.filename = amazon_pricecheck.log
  log4perl.appender.Logfile.mode = write
  log4perl.appender.Logfile.layout = Log::Log4perl::Layout::PatternLayout
  log4perl.appender.Logfile.layout.ConversionPattern = %d %p> %m%n
  log4perl.appender.Logfile.layout.ConversionPattern = %p: %d: %F(%L): %m%n~~~%n

  log4perl.appender.Screen        = Log::Log4perl::Appender::Screen
  log4perl.appender.Screen.stderr = 0
  log4perl.appender.Screen.layout = Log::Log4perl::Layout::PatternLayout
  log4perl.appender.Screen.layout.ConversionPattern = %p: %d: %F(%L): %m%n

  log4perl.appender.ParsingAppender = Log::Log4perl::Appender::File
  log4perl.appender.ParsingAppender.filename = amazon_pricecheck_parsing.log
  log4perl.appender.ParsingAppender.mode = append
  log4perl.appender.ParsingAppender.layout = SimpleLayout


  log4perl.logger.main = WARN
  log4perl.logger.Amazon.PriceCheck = INFO
#  log4perl.logger.Amazon.PriceCheck.EmailSend = DEBUG
#  log4perl.logger.Amazon.PriceCheck.Products = DEBUG
#  log4perl.logger.Amazon.PriceCheck.EmailParser = DEBUG
  
  /;
# Create Singleton-Object
Log::Log4perl::init( \$log_conf );

our $schema;
our $dbh;

our $MYSQL_DATE_FORMAT = '%Y-%m-%d %H:%M:%S';

our $DEFAULT_EXPIRATION_IN_DAYS = 40;
our $MAX_ASINS_PER_REQUEST = 10;

our %AP_PRODUCT_URL_MAP =
  ( 
    'Apparel'              => 'Apparel', 
    'Automotive'           => 'Automotive', 
    'Baby'                 => 'Baby', 
    'Beauty'               => 'Beauty', 
    'Books'                => 'Books', 
    'Library Binding'      => 'Books', 
    'Classical'            => 'Classical', 
    'DVD'                  => 'DVD', 
    'Digital Music'        => 'DigitalMusic', 
    'Electronics'          => 'Electronics', 
    'Gourmet Food'         => 'GourmetFood', 
    'HealthPersonalCare'   => 'HealthPersonalCare', 
    'Health and Beauty'    => 'HealthPersonalCare', 
    'HomeGarden'           => 'HomeGarden', 
    'Home and Garden'      => 'HomeGarden', 
    'Home and Beauty'      => 'HomeGarden',
    'Industrial'           => 'Industrial', 
    'Jewelry'              => 'Jewelry', 
    'Kitchen'              => 'Kitchen', 
    'MP3 Downloads'        => 'MP3Downloads', 
    'Magazines'            => 'Magazines', 
    'Merchants'            => 'Merchants', 
    'Miscellaneous'        => 'Miscellaneous', 
    'Music'                => 'Music', 
    'Musical Instruments'  => 'MusicalInstruments', 
    'Office Products'      => 'OfficeProducts', 
    'Outdoor Living'       => 'OutdoorLiving', 
    'PC Hardware'          => 'PCHardware', 
    'Pet Supplies'         => 'PetSupplies', 
    'Photo'                => 'Photo', 
    'Silver Merchants'     => 'SilverMerchants', 
    'Software'             => 'Software', 
    'SportingGoods'        => 'SportingGoods', 
    'Tools'                => 'Tools', 
    'Toy'                  => 'Toys', 
    'Toys'                 => 'Toys', 
    'Unbox Video'          => 'UnboxVideo', 
    'VHS'                  => 'VHS', 
    'Video'                => 'Video', 
    'Video Games'          => 'VideoGames', 
    'Wireless'             => 'Wireless', 
    'Wireless Accessories' => 'WirelessAccessories', 
  );

sub get_pkg_logger {
  my ($pkg) = @_;

  unless ($pkg) {
    ($pkg) = caller;
  }

  return Log::Log4perl->get_logger( $pkg );
}


our %MAILBOX =
  ( 'username'        => 'amazon-test+wdr1.com',
    'password'        => 'amazon-test',
    'host'            => 'mail.wdr1.com',
    'delete_messages' => 0,
    'debug'           => 0,
  );

our $SENDMAIL = '/usr/sbin/sendmail -t';

our $POST_LOAD_NOTIFICATION_TEMPLATE = 'post_load_notification_template.tt';

our $amazon_agent;
sub get_amazon_agent {
  unless ($amazon_agent) {
    $amazon_agent = Net::Amazon->new(token => $AMAZON_TOKEN,
                                     strict => 1,
                                    );    
  }
  
  return $amazon_agent;
}


our $tt;
sub get_template_toolkit_object {
  unless ($tt) {
    my $config = { INCLUDE_PATH => 'templates',
                   EVAL_PERL    => 1,
                 };
    $tt = Template->new($config);
  }

  return $tt;
}


our %URL = ( 'base' => 'http://ns2.amusive.com:3000',
             'guid_list' => '/guid/list',
           );



sub init_db_connections {
  $dbh = DBI->connect("dbi:mysql:wdr1_amzn", "wdr1_amzn", "wdr1_amzn")
    || die("Couldn't get dbh handle: ", $DBI::errstr);

  $schema = Amazon::PriceCheck::Schema::connect_schema();
}

## TODO: lazy way, let's just init at the start
&init_db_connections();
1;
__END__
# Below is stub documentation for your module. You'd better edit it!
