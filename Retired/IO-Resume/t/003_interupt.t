#!/usr/local/bin/perl -w

use strict;
use IO::Resume;

use lib 't';
use IOResumeTestHelper;
  
use Test::More qw|no_plan|;

my $prior_file = 'line3.tmp';
sub return_blah {
  my ($line) = @_;

  chomp($line);

  if ($line eq 'line3') {
    if (-f $prior_file) {
      unlink( $prior_file ) || warn($!);
    } else {
      open(F, '>', $prior_file) || die($!);
      print F "foo\n";
      close(F) || warn($!);
      &{ $::SIG{INT} };
      return;
    }
  }

  return "blah - $line\n";
}

my $input  = 't/files/data1.in';
my $expected_output = 't/files/interupt1.out';

my ($tmp, $rv, @output);

$tmp = 'tmp.out';
unlink ($tmp) if (-f $tmp);
unlink ($prior_file) if (-f $prior_file);
@output = IO::Resume::run(
                          'function'  => \&return_blah,
                          'input_file'     => $input,
                          'output_file'    => $tmp,
                         );

open(F, ">>", $tmp) || die($!);
print F "shizzle\n";
close(F) || warn($!);

@output = IO::Resume::run(
                          'function'    => \&return_blah,
                          'input_file'  => $input,
                          'output_file' => $tmp,
                         );
$rv = ok( eq_file_and_file( $tmp, $expected_output ), "'$tmp' & '$expected_output'" );
unless ($rv) {
  print `diff $tmp $expected_output`;
}
unlink ($tmp) if (-f $tmp && $rv);



