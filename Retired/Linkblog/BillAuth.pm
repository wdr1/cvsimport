package BillAuth;

## My subclass of CGI::Session::Auth
##
## $Id: BillAuth.pm,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $
##

use 5.006;
use strict;
use warnings;

use base 'CGI::Session::Auth::DBI';

## Missing from CGI::Session::Auth
## - Roles
## - Permissions
## - Time-out sessions

require Exporter;

our @ISA = qw(Exporter);
our $VERSION = '$Version: $ ';

sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  
  my $self = $class->SUPER::new();
  
  bless($self, $class);
  return $self;  
}


sub is_logged_in {
  my $self = shift;

}

sub log_user_in {
  my $self = shift;
  
}
