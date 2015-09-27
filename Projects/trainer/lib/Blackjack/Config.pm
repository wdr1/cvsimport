package Blackjack::Config;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Log::Log4perl ':easy';


use base qw(Class::Accessor);
Blackjack::Config->mk_accessors(qw( blackjack_base
                                    shoe_load_path
                                    cached_shoe_load_path
                                    shoe_suffix
                                    cached_shoe_suffix
                                    player_shoe_path
                                    db_table_prefix
                                    db_user
                                    db_password
                                    db_dsn
                                    salt
                                    logger_level
                                   ));

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10);

our $FILESYSTEM_PRIMED = 0;

our $_schema;

our $LOGGER_LEVEL = $INFO;

if ( defined $ENV{BLACKJACK_LOGGER_LEVEL} ) {
  no strict;
  $LOGGER_LEVEL = ${ $ENV{BLACKJACK_LOGGER_LEVEL} };
}

Log::Log4perl->easy_init( $LOGGER_LEVEL ); 
our $logger = Log::Log4perl->get_logger(__PACKAGE__);
$logger->info( "Logger level: '$LOGGER_LEVEL'..." );

sub new {
  my $class = shift;
  my $user_config = { @_ };
  my $self;
  if (defined $user_config && ref($user_config) eq 'HASH') {
    $self = { %$user_config };
  }
  
  my $default_base = $self->{ 'blackjack_base'} || '/tmp/trainer/unit-testing/';
  $self->{ 'blackjack_base' } ||= $default_base;
  $self->{ 'cached_shoe_load_path'} ||= $default_base . 'shoe_cache/';
  $self->{ 'cached_shoe_suffix' } ||= '.scache';
  $self->{ 'shoe_load_path' } ||= 't/pristine_shoes/';
  $self->{ 'shoe_suffix' } ||= '.stxt';
  $self->{ 'player_shoe_path'} ||= $default_base . 'player_cache/';

  $self->{ 'db_table_prefix' } ||= 'ut_';
  $self->{ 'db_dsn' } ||= 'dbi:mysql:wdr1_blackjack';
  $self->{ 'db_user' } ||= 'wdr1_blackjack';
  $self->{ 'db_password' } ||= 'wdr1_blackjack';

  $self->{ 'salt' } ||= 'setec astronomy';

  $self->{ 'logger_level' } = $LOGGER_LEVEL;
  
  my $obj = $class->SUPER::new( $self );
  
  bless $obj, $class;
}


sub get_shoe_path {
  my ($self, $shoe) = @_;

  return $self->shoe_load_path() . $shoe . $self->shoe_suffix();
}


sub get_cached_shoe_path {
  my ($self, $shoe) = @_;
  
  return $self->cached_shoe_load_path() . $shoe . $self->cached_shoe_suffix();
}


sub get_player_shoe_path {
  my ($self, $player_id) = @_;

  confess( "No player_id passed.") unless ($player_id);
  
  return $self->player_shoe_path() . $player_id . $self->cached_shoe_suffix();
}


sub get_schema {
  my ($self) = @_;

  my $_schema;
  if (! defined( $_schema ) ) {
    $_schema = Blackjack::Schema->config_connect( $self );
  }

  return $_schema;
}


sub prime_filesystem {
  my ($self) = @_;

  ## Make it cheap to call us repeatedly
  unless ($self->{'force_prime'}) {
    return if ($FILESYSTEM_PRIMED);
  }

  ## Sorta a poor man's mkdir -p
  foreach my $d ( $self->blackjack_base,
                  $self->cached_shoe_load_path,
                  $self->player_shoe_path,
                  $self->shoe_load_path) {
    my $path = '';
    foreach my $dir (split '/', $d) {
      $path .= $dir . '/';
      unless (-d $path ) {
        mkdir $path || die ("Couldn't create '$path': $!");
      }
    }
  }
}


1;
