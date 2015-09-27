package Blackjack::PlayerShoe;

use strict;
use warnings;

use Carp;
use Data::Dumper;
use Storable;
use Log::Log4perl;

use Blackjack::Utility 'shuffle';

use base qw(Blackjack::PristineShoe Class::Accessor);
Blackjack::PristineShoe->mk_accessors(qw(config player shoe is_shoe_loaded ));

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10);

use Log::Log4perl qw(:levels);
our $logger = Log::Log4perl->get_logger(__PACKAGE__);

sub new {
  my $class = shift;
  my $self = { @_ };

  confess( "PlayerShoe constructor requires a Blackjack::Config." )
    unless( defined( $self->{config} ) and
            ref($self->{config}) eq 'Blackjack::Config' );

  confess( "PlayerShoe constructor requires a Blackjack::Player." )
    unless( defined( $self->{player} ) and
            ref($self->{player}) eq 'Blackjack::Player' );

  $logger->level( $self->{config}->logger_level() );
  
  my $obj = $class->SUPER::new( %$self );

  bless $obj, $class;
}


sub load_player_shoe {
  my ($self) = @_;

  my $player_shoe_file =
    $self->config()->get_player_shoe_path( $self->player()->id() );

  if (-f $player_shoe_file ) {
#    $logger->info("Retrieving shoe ('$player_shoe_file')...\n");
    my $data = retrieve( $player_shoe_file );
    $self->shoe( $data );
    $self->is_shoe_loaded( 1 );
  } else {
    $logger->info("Resetting shoe...\n");
    $self->reset_shoe();
  }

  $self->load_accessors();
}


sub load_accessors {
  my $self = shift;
  
  my $shoe = $self->shoe();
  foreach my $key (keys %{ $shoe->{fields} }) {
    $self->mk_ro_accessors( $key );
    $self->{$key} = $shoe->{fields}{$key};
  }
}


sub reset_shoe {
  my ($self) = @_;

  my $data = $self->load_pristine_shoe( $self->player()->shoe_type() );
  $self->shoe( $data );
  $self->load_accessors();
  $self->is_shoe_loaded( 1 );
  $self->store_shoe();
}


sub store_shoe {
  my ($self) = @_;

#  $logger->info( "Storing shoe...");
  $self->config()->prime_filesystem();
  
  my $player_shoe_file =
    $self->config()->get_player_shoe_path( $self->player()->id() );
  
  store( $self->shoe(), $player_shoe_file )
    || warn( "Can't store player shoe '$player_shoe_file': $!");

}


sub register_response {
  my ($self, $response, $correct) = @_;

  $self->load_player_shoe() unless ($self->is_shoe_loaded());
  my $shoe = $self->shoe();

  confess( "Hand does not exist in shoe!")
    unless (defined ($shoe->{hands}{$response}) );
  
  if ($correct) {
    if ($shoe->{hands}{$response}{w} - 1 < 0 ) {
      $shoe->{hands}{$response}{w} = 0;
    } else {
      $shoe->{hands}{$response}{w}--;
      $shoe->{weight}--;
    }
  } else {
    $shoe->{hands}{$response}{w} += $self->incorrect_response_weight();
    $shoe->{weight} += $self->incorrect_response_weight();
  }
  
  return $self->store_shoe();
}


sub deal {
  my ($self, $count) = @_;
  my ($hand, @deal_out);

  $count ||= 1;
  $logger->debug( "Dealing '$count' hands..." );

  $self->load_player_shoe() unless ($self->is_shoe_loaded());
  
  my $shoe = $self->shoe();
  while ($count--) {
    my $rnd = int(rand( $shoe->{weight} )) + 1;
    keys %{ $shoe->{hands} };  ## reset
    while ( (undef, $hand) = each %{ $shoe->{hands} } ) {
#      print "RND: $rnd,   HD: ", $hand->{w}, ",  TW: ", $shoe->{weight}, "\n"; 
      $rnd -= $hand->{w};
      unless ($rnd > 0) {
        push @deal_out, $hand;
        last;
      }
    }
  }

  return wantarray ? @deal_out : $deal_out[0] ;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Blackjack::SharedShoe - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Blackjack::SharedShoe;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Blackjack::SharedShoe, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>wdr1@amusive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
