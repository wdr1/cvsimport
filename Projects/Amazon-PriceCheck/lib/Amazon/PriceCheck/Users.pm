package Amazon::PriceCheck::Users;

## $Id: Users.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use strict;
use warnings;

use Carp 'cluck';
use Data::Dumper;
use Digest::MD5 qw|md5_hex md5_base64|;

use Amazon::PriceCheck::Data;
use Amazon::PriceCheck::Schema;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	create_or_get_user
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw();

sub create_or_get_user {
  my ($email, $password, $salt) = @_;

  cluck "No email address passed!" unless ($email);

  my $guid  ||= md5_hex( time + int(rand( 10 ** 10 )) );
  $salt     ||= md5_base64( time + int(rand( 10 ** 10 )) );
  ## if they didn't give a password, use garbage
  $password ||= md5_base64( time + int(rand( 10 ** 10 )) );
  
  my $user = $schema->resultset('Users')->find_or_create(
               { 'email'    => lc($email),
                 'salt'     => $salt,
                 'password' => $password,
                 'guid'     => $guid,
               });

  return $user;
}


1;
