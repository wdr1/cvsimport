package Blackjack::PristineShoe;

use strict;
use warnings;

use Carp;
use Storable;
use Data::Dumper;

use base qw(Class::Accessor);
Blackjack::PristineShoe->mk_accessors(qw(config));

use Log::Log4perl qw(:levels);
our $logger = Log::Log4perl->get_logger(__PACKAGE__);

our $VERSION = substr(q$Revision: 1.1.1.1 $, 10);
our $DEFAULT_INITIAL_WEIGHT = 2;

sub new {
  my $class = shift;
  my $self = { @_ };

  confess( "PristineShoe constructor requires a Blackjack::Config." )
    unless( defined( $self->{config} ) and
            ref($self->{config}) eq 'Blackjack::Config' );

  my $obj = $class->SUPER::new( $self );

  bless $obj, $class;
}


sub weight {
  my ($self) = @_;

  return $self->shoe()->{weight};
}

sub load_pristine_shoe {
  my ($self, $shoe_name) = @_;
  my ($shoe_data);
  
  my $cached_shoe_file = $self->config->get_cached_shoe_path( $shoe_name );
  my $shoe_file        = $self->config->get_shoe_path( $shoe_name );

  $logger->info("Loading pristine '$shoe_name'...");
  if (-f $cached_shoe_file) {
    $shoe_data = retrieve( $cached_shoe_file );
    die("Couldn't load '$shoe_data'!  Exiting...") unless ($shoe_data);
  } else {
    $shoe_data = $self->load_raw_shoe_file( $shoe_file );
    $self->config->prime_filesystem();
    store( $shoe_data, $cached_shoe_file) || warn ("Couldn't write '$cached_shoe_file': $!");
  }

  return $shoe_data;
}


sub load_raw_shoe_file {
  my ($self, $file) = @_;

  $logger->info("load_raw_shoe_file '$file'...");

  my $shoe = { 'fields' => {}, 'hands' => {} };
  my $line_num = 0;
  my $total_weight = 0;
  
  open(F, '<', $file) || confess("Couldn't read '$file': $!");
  while (<F>) {
    $line_num++;
    next if (/^\s*\#/);
    next if (/^\s*$/);
    chomp;

    if (/^\s*:/) {
      my ($key, $value) = $_ =~ m|^\s*(\S+)\s*=\s*(\S+)\s*$|;
      $key =~ s|^:||;
      $shoe->{fields}{$key} = $value;
      next;
    }
    
    my ($p1, $p2, @actions) = split /\s*,\s*/;
    my $hint = pop @actions;
    
    unless (scalar @actions == 10) {
      warn("Line $line_num ('$_') is malformed.  Skipping...");
      next;
    }

    my $hand_weight =
      $shoe->{fields}{initial_hand_weight} || $DEFAULT_INITIAL_WEIGHT;
    my $d = 2;
    foreach my $answer (@actions) {
      next if ($answer eq '-');
      my $hand = { 'p1' => $p1,
                   'p2' => $p2,
                   'd'  => $d, };
      my $key = $self->hand2key( $hand );
      $shoe->{hands}{$key} = { 'hand' => $hand,
                               'hint' => $hint, 
                               'w' => $hand_weight, 
                               'a'  => $answer };
      $d++;
      $total_weight += $hand_weight;
    }
  }
  $shoe->{weight} = $total_weight;
  
  return $shoe;
}


sub hand2key {
  my ($self, $hand) = @_;

  confess("Invalid hand: ", Dumper($hand))
    unless($hand->{d} && $hand->{p1} && $hand->{p2});
  
  return join("-", $hand->{d},
              $hand->{p1},
              $hand->{p2},
             );
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
