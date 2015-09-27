#!/usr/bin/python

import anydbm
from xml.dom.minidom import parseString, parse
from datetime import datetime, timedelta
import os 
import re
import httplib
import pickle
import cgi
import PyRSS2Gen

import pprint
pp = pprint.PrettyPrinter(indent=4)

db_handles = []
max_age = 35
db_path_base = "./"
db_path_template = db_path_base + "debug-__NUM__.db"

## open/create the dbs
for i in range(5):
    db_file = re.sub(r'__NUM__', "%d" % i, db_path_template)
    db = None
    if (os.path.exists(db_file)):
        db = anydbm.open(db_file, "w")
    else:
        print "Creating '%s'..." % db_file
        db = anydbm.open(db_file, "n")
        db[CREATE_KEY] = "%d" % datetime.now().toordinal()
        db_handles.append(db)
        
debug_db_summary()

## Clear out old data for the week, if rolling over
i = int((datetime.now().toordinal() % max_age) / 7)
print "i: ", i
if (datetime.now().toordinal() - int(db_handles[i][CREATE_KEY])
    > max_age):
    print "NOW: " , datetime.now().toordinal() 
    print "DB: " , int(db_handles[i][CREATE_KEY])
    print "MAX AGE: ",  max_age
    db_handles[i].close()
    db_handles[i] = anydbm.open(db_file, "n")
    print "Creating (reset) '%s'..." % db_file
    db_handles[i][CREATE_KEY] = "%d" % datetime.now().toordinal()
current_db_handle = db_handles[i]
        
debug_db_summary()
