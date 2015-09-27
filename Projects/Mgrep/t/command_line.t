# $Id: command_line.t,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

use Test::More qw|no_plan|;
use Data::Dumper;
use strict;

BEGIN { use_ok( 'Mgrep' ); }

my @tests =
  (
   ## '--from'
   {
    'cmdline' =>
    [ '--from', 'wdr1@pobox.com', 'afile' ],
    'output' =>
    {
     '_matches' => { 'from' => 'wdr1@pobox.com' },
     '_mailboxes' => [ 'afile' ],
    }
   },
   
   ## Simple test '-from'
   {
    'cmdline' =>
    [ '-from', 'wdr1@pobox.com', 'afile' ],
    'output' =>
    {
     '_matches' => { 'from' => 'wdr1@pobox.com' },
     '_mailboxes' => [ 'afile' ],
    }
   },
   
   ## Simple test '-from'
   {
    'cmdline' =>
    [ '-from', 'wdr1@pobox.com', 'afile' ],
    'output' =>
    {
     '_matches' => { 'from' => 'wdr1@pobox.com' },
     '_mailboxes' => [ 'afile' ],
    }
   },

   ## '--from' & one file
   {
    'cmdline' =>
    [ '--from', 'wdr1@pobox.com', 'afile' ],
    'output' =>
    {
     '_matches' => { 'from' => 'wdr1@pobox.com' },
    '_mailboxes' => [ 'afile' ],
    }
   },
   
   ## '--from' & two files
   {
    'cmdline' =>
    [ '--from', 'wdr1@pobox.com', 'afile', 'asecondfile' ],
    'output' =>
    {
     '_matches' => { 'from' => 'wdr1@pobox.com' },
    '_mailboxes' => [ 'afile', 'asecondfile' ],
    }
   },
   
   ## mgrep subjectPattern mailbox1
   {
    'cmdline' =>
    [ 'subjectPattern', 'mailbox1' ],
    'output' =>
    {
     '_matches' => { 'From' => 'subjectPattern', 'Subject' => 'subjectPattern' },
    '_mailboxes' => [ 'mailbox1' ],
    }
   },
   
  );

my $DEFAULT_OPTIONS = {
                    'result_format' => "From:15 Subject:50\n",
                    'rf_sprintf' => "%-15.15s %-50.50s\n",
                    'rf_columns' => [ 'From', 'Subject'],
                    };

foreach my $test (@tests) {
  my ($input, $expected_output) = ($test->{cmdline},
                                   { %{ $test->{output} }, %$DEFAULT_OPTIONS },
                                  );
  my $actual_output = &Mgrep::parse_commandline( @$input );
#  print Dumper( {'input' => $input, 'expected' => $expected_output, 'actual' => $actual_output} );
  is_deeply( $actual_output, $expected_output );
}
