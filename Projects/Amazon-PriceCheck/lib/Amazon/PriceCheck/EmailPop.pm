package Amazon::PriceCheck::EmailPop;

use 5.008008;
use strict;
use warnings;

use Log::Log4perl;
use Net::POP3;
use Carp;
use Data::Dumper;

use Amazon::PriceCheck::Data;

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
);

our $VERSION = '0.01';

our $logger = get_pkg_logger();

sub new {
  my ($class) = @_;
  
  my $self = {'pid' => undef,
             'pop' => undef,
             };
  
  bless( $self, $class);
}


sub pid {
  my ($self) = @_;

  return $self->{pid};
}


sub init {
  my ($self) = @_;

  my %config = %Amazon::PriceCheck::Data::MAILBOX;
  $logger->debug( "-- POP Config --\n", Dumper( \%config ), "-- --\n");
  my $pop = Net::POP3->new( $config{host},
                            Debug => $config{debug} )
    || confess( "Couldn't connect to '", $config{host}, "'!" );
  $self->{pop} = $pop;

  unless ($pop->login( $config{username}, $config{password} )) {
    confess("Unable to login to pop server: $!");
  }

  $self->{msg_list} = [ keys %{ $pop->list() } ];
}


sub next_message {
  my ($self) = @_;

  my $msg_list = $self->{msg_list};
  my $pop = $self->{pop};

  my $msg_id = pop @$msg_list;
  return unless ($msg_id);
  
  my $msg_body = $pop->get( $msg_id );
  $logger->trace( "-- Email Message ($msg_id) --\n",
                  join("", @$msg_body),
                  "-- --\n");
  if ($AMAZON::PRICECHECK::DATA::MAILBOX{'delete_messages'}) {
    $logger->info("Deleting $msg_id...");
    $pop->delete( $msg_id );
  }

  unless (@$msg_list) {
    $logger->debug("Quitting POP connection...");
    $pop->quit();
  }

  return join("", @$msg_body);
}



1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Amazon::PriceCheck - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Amazon::PriceCheck;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Amazon::PriceCheck, created by h2xs. It looks like the
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

A. U. Thor, E<lt>wdr1@localdomainE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
