package AmazonPriceCheck::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'AmazonPriceCheck::Schema',
    connect_info => [
        'dbi:mysql:dbname=wdr1_amzn',
        'wdr1_amzn',
        'wdr1_amzn',
        
    ],
);

=head1 NAME

AmazonPriceCheck::Model::DB - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<AmazonPriceCheck>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<AmazonPriceCheck::Schema>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
