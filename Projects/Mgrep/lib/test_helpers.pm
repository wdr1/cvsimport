#!/usr/local/bin/perl -w

# $Id: test_helpers.pm,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use strict;
use Cwd;

## Just slurp in a file w/ error checking.  I'd use IO::All, but it's not part of the base
## install & I don't want people to have to install it just to run these tests.
sub slurp {
  my ($file) = @_;
  local $/ = undef;

  open(F, '<', $file) || die("Couldn't read '$file': $!");
  my $results = <F>;
  close(F) || warn("Trouble closing '$file': $!");

  return $results;
}

## Hack so we can run tests from anywhere, is there a better way to do
sub mgrep_abs_path {
  my ($file) = @_;

  my $srctop = &getcwd();
  $srctop =~ s|^(.*)/Mgrep/?.*$|$1/Mgrep/|;

  return $srctop . $file;
}  

1;
