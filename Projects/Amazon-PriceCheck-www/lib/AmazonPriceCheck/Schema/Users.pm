package AmazonPriceCheck::Schema::Users;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("users");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "email",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 255 },
  "password",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 128 },
  "guid",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 128 },
  "crt_ts",
  {
    data_type => "TIMESTAMP",
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
    size => 14,
  },
  "salt",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 128,
  },
  "password_recovery",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 128,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idx_users_email", ["email"]);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-09-21 17:35:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bwsaa1earPN/1Y/YaG5/JA

__PACKAGE__->has_many(users_x_products => 'AmazonPriceCheck::Schema::UsersXProducts',
                       'user_id');

1;
