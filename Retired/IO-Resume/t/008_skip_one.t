#!/usr/local/bin/perl -w

use strict;
use IO::Resume;

use lib 't';
use IOResumeTestHelper;
  
use Test::More qw|no_plan|;

sub return_blah {
  my $line = shift;
  chomp($line);
  return "$line - blah\n";
}

my $test_name = $0;
$test_name =~ s|.*/([^/]+)\.t$|$1|;

my $input_file           = "t/files/$test_name.in";
my $expected_output_file = "t/files/$test_name.out";
my $tmp_file             = "$test_name.tmp";

unlink ($tmp_file) if (-f $tmp_file);

my $rv = IO::Resume::run(
                         'function'    => \&return_blah,
                         'input_file'  => $input_file,
                         'output_file' => $tmp_file,
                         'skip'        => '2',
                        );
$rv = ok( eq_file_and_file( $tmp_file, $expected_output_file ), "'$tmp_file' & '$expected_output_file'" );
unless ($rv) {
  print `diff $tmp_file $expected_output_file`;
}
unlink ($tmp_file) if (-f $tmp_file);



