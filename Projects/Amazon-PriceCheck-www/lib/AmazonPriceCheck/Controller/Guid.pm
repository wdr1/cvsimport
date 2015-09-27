package AmazonPriceCheck::Controller::Guid;

use strict;
use warnings;
use parent 'Catalyst::Controller';

use Data::Dumper;

=head1 NAME

AmazonPriceCheck::Controller::Guid - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut


sub auto :Private {
  my ($self, $c, $guid) = @_;

  unless ($self->is_guid_valid( $c, $guid )) {
    $c->response->redirect($c->uri_for('/site/invalid'));
    return 0;
  }

  return 1;
}


sub index :Local {
    my ( $self, $c, $guid ) = @_;

    $c->response->body('Matched AmazonPriceCheck::Controller::Guid in Guid.');
}


sub delete :Local {
  my ($self, $c, $guid, $prod_id) = @_;

  my $user_id = $c->stash->{user}->id;
  $c->log->debug("Removing $user_id/$prod_id (user_id/prod_id)...");

  $c->model('DB::UsersXProducts')->search( {user_id => $user_id,
                                            prod_id => $prod_id}
                                         )->delete;

  $c->stash->{status_msg} = 'Product deleted...';
  $c->detach('list');
}


sub extend :Local {
  my ($self, $c, $guid, $prod_id) = @_;

  my $extend_by = 14;
  my $user_id = $c->stash->{user}->id;
  my $expersion = "ADDDATE(end_ts, $extend_by)";
  $c->model('DB::UsersXProducts')->search( {user_id => $user_id,
                                            prod_id => $prod_id}
                                         )->update({'end_ts' =>
                                                    \$expersion });
  
  $c->stash->{status_msg} = 'Expiration extended 14 days...';
  $c->detach('list');
}

  
sub list :Local {
  my ($self, $c, $guid) = @_;

  ## TODO:  grab all this info in auto (so only 1 query)
  my @products =
    $c->model('DB::UsersXProducts')->search( {user_id => 1 },
                                             {prefetch => [ 'users', 'products' ]}
                                           )->all;
  
  $c->stash->{products} = \@products;

  $c->stash->{template} ='site/list_products.tt';
}


sub is_guid_valid :Private {
  my ($self, $c, $guid) = @_;

  $c->log->debug("*** Looking for GUID '$guid'...");
  my @rows = $c->model('DB::Users')->search({ 'guid' => $guid },
                                          { 'count' => 1 }
                                         )->all();
  
  $c->log->debug("*** Search for GUID '$guid' found '" . 
                 scalar @rows .  "' row(s)...");
  if (scalar @rows > 1) {
    $c->log->error("More than row found for '$guid'!");
  }

                 
  $c->stash->{user} = $rows[0];
  
  return scalar @rows;
}


  

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
