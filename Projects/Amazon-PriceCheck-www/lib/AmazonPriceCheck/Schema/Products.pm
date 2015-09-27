package AmazonPriceCheck::Schema::Products;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("products");
__PACKAGE__->add_columns(
  "id",
  { data_type => "BIGINT", default_value => undef, is_nullable => 0, size => 20 },
  "product_name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 255 },
  "asin",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 30 },
  "last_seen_price",
  { data_type => "DECIMAL", default_value => undef, is_nullable => 1, size => 9 },
  "last_seen_date",
  {
    data_type => "DATETIME",
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
    size => 19,
  },
  "category",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idx_products_asin", ["asin"]);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-09-21 17:35:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DQJTWhX3Lt3NvIiQyX5wdg

__PACKAGE__->has_many(users_x_products => 'AmazonPriceCheck::Schema::UsersXProducts',
                       'prod_id');

1;
