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
my $simple2_out = 't/files/simple2.out';

my ($tmp, $rv, @output);

$tmp = 'tmp.out';
unlink ($tmp) if (-f $tmp);
@output = IO::Resume::run(
                          'function'  => \&return_blah,
                          'input_file'     => $data1_in,
                          'output_file'    => $tmp,
                          'row_start' => 3,
                         );
$rv = ok( eq_file_and_file( $tmp, $simple2_out ), "row start: '$tmp' & '$simple2_out'" );
unlink ($tmp) if (-f $tmp && $rv);



