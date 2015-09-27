#!/usr/local/bin/perl -w

use strict;
use Template;

our @CONTENT = (
                { 'section' => 'about',
                  'pages'   => (
                                { 'template'  => 'about'
                                  'title'     => 'About Blackjack'},
                               )
                },
                { 'section' => 'play',
                    'pages'   => (
                                  { 'template' => 'about'
                                    'title'    => 'About Blackjack'},
                                 )
                },
                { 'section' => 'tutor',
                    'pages'   => (
                                  { 'template' => 'learn'
                                    'title'    => 'Learn Basic Strategy'},
                                 )
                },
                { 'section' => 'books',
                    'pages'   => (
                                  { 'template' => 'books'
                                    'title'    => 'Books'},
                                 )
                },
               );
              


&main();



###################################################################  main  ###
## 
sub main {

  my $h = { 'g' => {},  ## For global data
            'p' => {}   ## For page data
            };

  my $tconfig = {
                 INCLUDE_PATH => 'templates/', 
                 INTERPOLATE  => 1,            
                 POST_CHOMP   => 1,            
                 EVAL_PERL    => 1,            
                };  

  foreach my $c (@CONTENT) {
    foreach my $p (@{ $c->{pages} }) {
      $h->{p} = {};
      
    }
  }
  
  
}




