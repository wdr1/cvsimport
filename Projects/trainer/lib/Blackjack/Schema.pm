package Blackjack::Schema;

use Carp;

use base qw/DBIx::Class::Schema::Loader/;

__PACKAGE__->loader_options();

sub config_connect {
  my ($self, $config) = @_;

  confess( __PACKAGE__ . " constructor requires a Blackjack::Config." )
    unless( defined( $config ) and ref($config) eq 'Blackjack::Config' );

  return $self->connect( $config->db_dsn(),
                         $config->db_user(),
                         $config->db_password() );
}
