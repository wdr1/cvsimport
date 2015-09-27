#!/bin/bash

## $Id: install.sh,v 1.1.1.1 2010/08/14 04:57:50 wdr1 Exp $

## Created 06/19/05 -- William Reardon <wdr1@pobox.com>
##
## Place all our files in the proper places, such that
## if we remove the directory the checkout directory everything
## is still okay.

## Hard link our files
for i in * .* 
do
  if [[ $i == '.' || $i == '..' ]]; then continue; fi
  if [[ $d == 'install.sh' ]]; then continue; fi
  
  if [ -f $i ]; then
      if [ -f "$HOME/$i" ]; then
          echo "$HOME/$i already exists..."
      else
          echo "Hard linking $i..."
          ln $i "$HOME/$i"
      fi
  fi
done

## We can't hard link directories, so we have to move the directories
## into the proper location & then symlink to them from here.
for d in * .*
do
  if [ -d $d ]; then
     if [[ $d == '.' || $d == '..' ]]; then continue; fi
     if [[ $d == 'CVS' ]]; then continue; fi


     if [ -d "$HOME/$d" ]; then 
         echo "$HOME/$d already exists..."
     else
         echo "Moving $d & symlinking...";
         mv $d $HOME/;
         ln "$HOME/$d"; 
     fi
  fi
done  