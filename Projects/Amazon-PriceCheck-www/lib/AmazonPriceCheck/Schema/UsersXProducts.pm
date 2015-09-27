package AmazonPriceCheck::Schema::UsersXProducts;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("users_x_products");
__PACKAGE__->add_columns(
  "id",
  { data_type => "BIGINT", default_value => undef, is_nullable => 0, size => 20 },
  "user_id",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 10 },
  "prod_id",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 10 },
  "purchase_price",
  { data_type => "DECIMAL", default_value => undef, is_nullable => 1, size => 9 },
  "lowest_seen_price",
  { data_type => "DECIMAL", default_value => undef, is_nullable => 1, size => 9 },
  "end_ts",
  {
    data_type => "DATETIME",
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
    size => 19,
  },
  "crt_ts",
  {
    data_type => "TIMESTAMP",
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
    size => 14,
  },
  "email_hash",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-09-21 17:35:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NdPF6EjO41UspqTm152sew
__PACKAGE__->belongs_to(users => 'AmazonPriceCheck::Schema::Users', 'user_id');
__PACKAGE__->belongs_to(products => 'AmazonPriceCheck::Schema::Products', 'prod_id');


# You can replace this text with custom content, and it will be preserved on regeneration
1;
