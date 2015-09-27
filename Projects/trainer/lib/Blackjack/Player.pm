package Blackjack::Player;

use strict;
use warnings;

use Carp;
use Storable;
use Data::Dumper;
use Digest::MD5;

use Blackjack::Schema;
use Digest::MD5 qw|md5_base64|;

use base qw(Class::Accessor);
our @required_fields = qw(name email password shoe_type);
Blackjack::Player->mk_accessors( 'id', @required_fields );

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10);

sub new {
  my $class = shift;
  my $self = { @_ };

  confess( "Player constructor requires a Blackjack::Config." )
    unless( defined( $self->{config} ) and
            ref($self->{config}) eq 'Blackjack::Config' );
  confess( "Player constructor requires an email address." )
    unless( defined( $self->{player}{email} ) || defined ($self->{email}) );

  if ($self->{email}) {
    $self->{player}{email} = $self->{email};
  }
  if ($self->{shoe_type}) {
    $self->{player}{shoe_type} = $self->{shoe_type};
  }
#  $self->{player}{shoe_type} ||= 'simple';
  $self->{player}{shoe_type} ||= 'full';
  
  ## TODO:  Eventually this is likely to be the DB id
  confess('Missing email address!') unless ( $self->{player}{email} );
  my $id = md5_base64( $self->{player}{email} );
  $id =~ s|/|_|g;
  $self->{player}{ 'id' } ||= $id;

  my $obj = $class->SUPER::new( $self->{player} );

  bless $obj, $class;
}

sub hash_password {
  my ($password, $salt) = @_;

  confess("Both password & salt are required!") unless ($password && $salt);

  return md5_base64( $salt . $password );
}


sub load_player {
  my $self = shift;
  my $args = { @_ };
  
  my $player = $args->{player} || {};
  if (defined ($args->{player_id})) {
    $player->{id} = $args->{player_id};
  }
  if (defined ($args->{player_email})) {
    $player->{email} = $args->{player_email};
  }
  unless( defined($player->{id}) || defined($player->{email}) ) {
    confess( caller() . " requires an 'id' or 'email'!");
  }
  
  confess( "Player constructor requires a Blackjack::Config." )
    unless( defined( $args->{config} ) and
            ref($args->{config}) eq 'Blackjack::Config' );
  my $config = $args->{config};
  my $schema = $config->get_schema();
  
  my %player_data = $schema->resultset('Blackjack')->search( $player )->next()->get_columns();

  return new Blackjack::Player( 'player' => \%player_data,
                                'config' => $config,
                              );
}


sub create_player {
  my ($self, $player_settings) = @_;

  confess( "Player constructor requires a Blackjack::Config." )
    unless( defined( $player_settings->{config} ) and
            ref($player_settings->{config}) eq 'Blackjack::Config' );
  
  my $config      = $player_settings->{config};
  my $player_args = $player_settings->{'player'};
  
  foreach my $field (@required_fields) {
    unless( $player_args->{$field} ) {
      confess("'$field' is required to " . caller() . "!");
    }
  }

  delete( $player_args->{'id'} ) if (defined( $player_args->{id} ));
  
  ## Hash the password
  $player_args->{'password'} =
    hash_password( $player_args->{'password'},
                   $config->salt(),
                 );

  my $schema = $config->get_schema();
  my $created_player =
    $schema->resultset('Blackjack')->create( $player_args );

  return $self->load_player( 'player' => { 'id' => $created_player->id() },
                             'config' => $config,
                           );
}


1;
