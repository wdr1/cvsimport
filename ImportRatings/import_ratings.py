#!/usr/bin/python

## import_ratings.py -- import iTunes ratings
##
## Author: William Reardon <wdr1@pobox.com  Created: 01/19/10
##
## $Id: import_ratings.py,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $
##

import pprint
import plistlib
import sys
from appscript import *

def importXMLRatings(ratingsXMLFile):
    print ratingsXMLFile
    pl = plistlib.readPlist(ratingsXMLFile)
    pl = pl['Tracks']
    for k,v in pl.items():
        if "Rating" not in v:
            continue
        if "Album" not in v:
            print "Skipping '%s'.  Missing the album name." % v['Name']
            continue
        if "Artist" not in v:
            print "Skipping '%s'.  Missing the artist name." % v['Name']
            continue
            
        print "Rating '%s' of '%s' by '%s' to '%d'..." % (v['Name'], v['Artist'], v['Album'], v['Rating'])
        try:
            app('iTunes').library_playlists[1].file_tracks[((its.name == v['Name']).AND(its.artist == v['Artist'])).AND(its.album == v['Album'])].rating.set(v['Rating'])
        except CommandError:
            print "Unable to rate '%s' of '%s' by '%s' to '%d'..." % (v['Name'], v['Artist'], v['Album'], v['Rating'])
    return 1

if __name__ == "__main__":
    ratingsXMLFile = sys.argv[1]
    importXMLRatings(ratingsXMLFile)
