package Amazon::PriceCheck::Schema;

use base qw/DBIx::Class::Schema::Loader/;

## TODO:  hardcoded data -> config

__PACKAGE__->loader_options(
#                            debug         => 1,
                           );

                           
sub connect_schema {                           
	my $schema = __PACKAGE__->connection("dbi:mysql:wdr1_amzn",
                                       "wdr1_amzn", "wdr1_amzn");

  Amazon::PriceCheck::Schema::UsersXProducts->belongs_to(
    'products',
    'Amazon::PriceCheck::Schema::Products',
    { 'foreign.id' => 'self.prod_id'},
                                                         );
  
  Amazon::PriceCheck::Schema::UsersXProducts->belongs_to(
    'users',
    'Amazon::PriceCheck::Schema::Users',
    { 'foreign.id' => 'self.user_id'},
                                                         );
  
  Amazon::PriceCheck::Schema::Products->has_many(
    'usersxproducts',
    'Amazon::PriceCheck::Schema::UsersXProducts',
    { 'foreign.prod_id' => 'self.id'},
                                                         );
  Amazon::PriceCheck::Schema::Users->has_many(
    'usersxproducts',
    'Amazon::PriceCheck::Schema::UsersXProducts',
    { 'foreign.user_id' => 'self.id'},
                                                         );
                                                         
  return $schema
}


1;
