package Amazon::PriceCheck::EmailSend;

# $Id: EmailSend.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use 5.008008;
use strict;
use warnings;

use Carp;
use Amazon::PriceCheck::Data;


require Exporter;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw(
  send_post_load_notification
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(
);

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10);
our $logger = get_pkg_logger();

sub send_post_load_notification {
  my ($user, $product_results) = @_;

  my $tt = get_template_toolkit_object();
  my $template = $POST_LOAD_NOTIFICATION_TEMPLATE;
  my $message = undef;

  my $data = { 'user'    => $user,
               'url'     => \%URL,
               'product' => $product_results };

  $tt->process($template, $data, \$message) || confess( $tt->error() );

  &send_email( $message );
}


sub send_email {
  my ($message) = @_;

  if ($ENV{'AMZN_DISABLE_EMAIL'}) {
    $logger->info("Email disabled.  Skipping message...");
    return 0;
  }
  
  $logger->debug("Sending email: '$message'...");

  open(SENDMAIL, "|$SENDMAIL") || die("Cannot open '$SENDMAIL': $!");
  print SENDMAIL $message;
  close (SENDMAIL) || confess("Error closing sendmail: $!");
  
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!
