package Amazon::PriceCheck::EmailParser;

use 5.008008;
use strict;
use warnings;

use Net::Amazon;
use Log::Log4perl qw(:easy);
use Data::Dumper;
use Carp 'cluck';

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
  parse_email
  extract_products_from_email
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} },
                 );

our @EXPORT = qw();

our $VERSION = '0.01';

our $logger = get_pkg_logger();


sub parse_email {
  my ($msg) = @_;

  ## Get their email address
  ## TODO: support Reply-To & error checking
  my $from;
  ($from) = $msg  =~ m|^From:\s+(.*)$|m;
  ($from) = $from =~ m|(\S+@\S+)|;
  $from =~ s|<(.*)>|$1|;

  my $products = &extract_products_from_email( $msg );

  return { 'email'    => $from,
           'products' => $products,
         };
}


sub extract_products_from_email {
  my ($msg) = @_;
  

  my $product_section;
  ($product_section) = $msg =~ /\*(Delivery estimate:.*?)\-{20,}/s;
  $product_section =~ s|^.+?(\*\d)|$1|sg;
  $product_section =~ s|\s+$||s;

  unless ($product_section) {
    $logger->warn("Unable to extract products!\n",
                  "-- vv   Original Message   vv --\n",
                  $msg,
                  "-- ^^   Original Message   ^^ --\n");
    return ();
  }

  ## get rid of the header & footer, then chop up
  my @raw_product_chunks = split /\n\n\n/, $product_section;

  ## snag the details out of each chunk
  my @results = ();
  foreach my $chunk (@raw_product_chunks) {
    my ($product_chunk, $details_chunk) = split /"\*\n/, $chunk;
    my ($product_name) = $product_chunk =~ /\*\d+\*\s+\*"(.*)/s;
    $product_name =~ s/\n//g;  ## get rid of newlines in the product name
    
    my @details = split /; /, $details_chunk; 
    shift @details if (scalar @details == 3);  ## get rid of publisher if present
    my ($category, $price) = @details;
    $price =~ s|(\.\d\d).*|$1|s;
    $price =~ s|^\$||;
    
    my $details = { 'product_name' => $product_name,
                    'category'     => $category,
                    'price'        => $price,
                  };

    unless ($product_name && $price) {
      $logger->warn("Unable to full parse product info from chunk: ",
                    Dumper( $details ),
                    "Chunk '$product_chunk'");
    }

    push @results, $details;
  }

  $logger->debug("Products extracted: => ", Dumper( \@results ));
  
  return \@results;
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
