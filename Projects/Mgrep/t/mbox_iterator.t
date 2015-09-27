use Test::More 'no_plan';

BEGIN { use_ok( 'Mgrep' ); }
require test_helpers;

{
  my $file = &mgrep_abs_path( 't/mail/perl' );
  my $i = Mgrep::get_mbox_iterator( $file );
  my $c = 0;
  while ( $header = $i->() ) {
    $c++;
  }
  ok($c == 1306, "Number of messages found in '$file'");
}

{
  my $file = &mgrep_abs_path( 't/mail/hip-hop.2' );
  my $i = Mgrep::get_mbox_iterator( $file );
  my ($out, $header, $body);
  while ( 1 ) {
    ($header, $body) = $i->();
    last unless ($header);
    $out = "$out$header\n$body";
  }
  open(F, '<', "$file.out") || die($!);
  local $/ = undef;
  my $expected_out = <F>;
  ok($out eq $expected_out);
}
