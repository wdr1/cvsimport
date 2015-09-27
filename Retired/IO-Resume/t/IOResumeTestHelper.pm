package IOResumeTestHelper;

## $Id: IOResumeTestHelper.pm,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

use strict;
use warnings;

use Test::More;
use Carp qw|cluck confess croak carp|;
use Data::Dumper;

require Exporter;

our @STATIC_FILE_SEARCH_PATH = qw|
  ./
  t/
  t/files/
|;

our @ISA = qw|Exporter|;
our @EXPORT = qw|
  eq_arrayref_and_file
  eq_file_and_file
  expand_file_name
|;

## Compare an array to the contents of a file
sub eq_arrayref_and_file {
  my ($arr, $file ) = @_;

  open(F, '<', $file) || confess("Couldn't open '$file': $!");
  my @results = <F>;
  close(F) || cluck("Trouble closing '$file': $!");
  
  return eq_array( $arr, \@results );
}

## Compare the contents of two files
sub eq_file_and_file {
  my ($file1, $file2 ) = @_;

  open(F, '<', $file1) || confess("Couldn't open '$file1': $!");
  my @r1 = <F>;
  close(F) || cluck("Trouble closing '$file1': $!");

  open(F, '<', $file2) || confess("Couldn't open '$file2': $!");
  my @r2 = <F>;
  close(F) || cluck("Trouble closing '$file2': $!");

#  print Dumper( \@r1, \@r2 );

  return eq_array( \@r1, \@r2 );
}


sub expand_file_name {
  my ($file) = @_;

  foreach my $dir (@STATIC_FILE_SEARCH_PATH) {
    if (-f "${dir}${file}" ) {
      return "${dir}${file}";
    }
  }

  warn ("Unable to find '$file'!");
  return undef;
}
