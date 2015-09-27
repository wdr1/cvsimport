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
@output = IO::Resume::run(
                          'function' => \&return_blah,
                          'input_file'    => $data1_in,
                          'silent'   => 0,
                          'output_file'   => $tmp,
                         );
`cat $tmp`;  ## hack!
$rv = ok( eq_file_and_file( $tmp, $simple1_out ), "'$tmp' & '$simple1_out'" );
exit(0);

unlink ($tmp) if (-f $tmp);
@output = IO::Resume::run(
                          'function' => \&return_blah,
                          input_file    => $data1_in,
                          'silent'   => 0,
                          'output'   => $tmp,
                          'row_start' => 3,
                         );
#`cat $tmp`;  ## hack!
$rv = ok( eq_file_and_file( $tmp, $simple1_out ), "'$tmp' & '$simple2_out'" );
unlink ($tmp) if (-f $tmp);



