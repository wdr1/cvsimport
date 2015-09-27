#!/usr/local/bin/perl -w

use strict;
use IO::Resume;

use lib 't';
use IOResumeTestHelper;
  
use Test::More qw|no_plan|;

sub return_blah {
  return "blah\n";
}

my $data1_in    = 't/files/data1.in';
my $simple1_out = 't/files/simple1.out';
my $simple2_out = 't/files/simple2.out';

my ($tmp, $rv, @output);

$tmp = 'tmp1.out';
unlink ($tmp) if (-f $tmp);
$rv = IO::Resume::run(
                      'function'    => \&return_blah,
                      'input_file'  => $data1_in,
                      'output_file' => $tmp,
                     );
$rv = ok( eq_file_and_file( $tmp, $simple1_out ), "'$tmp' & '$simple1_out'" );
unless ($rv) {
  print `diff $tmp $simple1_out`;
}
unlink ($tmp) if (-f $tmp);



