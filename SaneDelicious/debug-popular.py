#!/usr/bin/python

# $Id: debug-popular.py,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

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

CREATE_KEY = '__create__'
DEBUG = False

class SeenURLs:
    "Have the url been seen?"
    def __init__(self):
        self.db_handles = []
        self.max_age = 35
        db_path_base = "/home/wdr1/Sandboxes/wdr1/SaneDelicious/cache/"
        self.db_path_template = db_path_base + "sane-delicious-__NUM__.db"

        ## open/create the dbs
        for i in range(5):
            db_file = re.sub(r'__NUM__', "%d" % i, self.db_path_template)
            db = None
            if (os.path.exists(db_file)):
                db = anydbm.open(db_file, "w")
            else:
                print "Creating '%s'..." % db_file
                db = anydbm.open(db_file, "n")
                db[CREATE_KEY] = "%d" % datetime.now().toordinal()
            self.db_handles.append(db)

        ## Clear out old data for the week, if rolling over
        i = int((datetime.now().toordinal() % self.max_age) / 7)
        if (datetime.now().toordinal() - int(self.db_handles[i][CREATE_KEY])
            > self.max_age):
            self.db_handles[i].close()
            db_file = re.sub(r'__NUM__', "%d" % i, self.db_path_template)
            self.db_handles[i] = anydbm.open(db_file, "n")
            print "Creating (reset) '%s'..." % db_file
            self.db_handles[i][CREATE_KEY] = "%d" % datetime.now().toordinal()
        self.current_db_handle = self.db_handles[i]
        
        ## Current links
        self.max_links = 500
        self.pickle_file = db_path_base + "links.pickle"
        self.links = []
        if (os.path.exists(self.pickle_file)):
            f = open(self.pickle_file, 'rb')
            self.links = pickle.load(f)
            f.close()
            
    def close(self):
        for db in self.db_handles:
            db.close()
                
    def damnit(self):
        for db in self.db_handles:
            for k in db.keys():
                print k, '-', db[k]

    def debug_db_summary(self):
        for i in range(5):
            print "CREATE: ", i, " ", self.db_handles[i][CREATE_KEY], \
               "(", len(self.db_handles[i].keys()), ")"
            
        
    def been_seen(self, url):
        url = clean_url(url)
        seen = False
        for h in self.db_handles:
            if h.has_key(url):
                seen = True
                break
        return seen
    
    def register(self, pair):
        url = clean_url(pair['link'])
        self.current_db_handle[url] = "1"
        self.links.insert(0, pair)
        if (len(self.links) > self.max_links):
            self.links.pop()
    
    def been_seen_and_register(self, url):
        seen = self.beenSeen(url)
        self.register(url)
        return seen
    
    def __del__(self):
        f = open(self.pickle_file, 'wb')
        pickle.dump(self.links, f)
        f.close()
    

def get_delicious_xml():
    if (DEBUG):
        dom = parse("full.xml")
        return dom

    conn = httplib.HTTPConnection("feeds.delicious.com")
    conn.request("GET", "/v2/rss/popular?count=100")
    r1 = conn.getresponse()
    xml = r1.read()
    dom = parseString(xml)
    return dom

def getTextSingle(node):
    parts = [child.data for child in node.childNodes if child.nodeType == node.TEXT_NODE]
    return u"".join(parts)

def getText(nodelist):
    return u"".join(getTextSingle(node) for node in nodelist)

def clean_url(url):
    ## Get rid of anchors
    url = re.sub(r'#[^#]+$', "", url)
    return url

def extract_items(dom):
    links = []
    items = dom.getElementsByTagName("item")
    for i in items:
        title = getText( i.getElementsByTagName("title") )
        link = getText( i.getElementsByTagName("link") )
        links.append( {'title': title.encode("iso-8859-1", "replace"),
                       'link': link.encode("iso-8859-1", "replace")} )
    return links


def render_html(links, file):
    template = "<LI> <A HREF='%s'>%s</A><P/>\n"
    f = open(file, 'w')
    for l in links:
        s = template % (cgi.escape(l['link']),
                        cgi.escape(l['title']))
        f.write(s)
    f.close()

def render_xml(links, file):
    rss_items = []
    for l in links:
        rss_items.append(
            PyRSS2Gen.RSSItem( title = l['title'],
                               link = l['link'],
                               description = "",
                               guid = PyRSS2Gen.Guid(l['link']),
                               pubDate = l['pubDate'],
                               ))

    rss = PyRSS2Gen.RSS2(
        title = "Tasty Links",
        link = "http://wdr1.com/tasy/",
        description = "A simplified view of popular links from delicious",

        items = rss_items
        )
    rss.write_xml(open(file, "w"))

def main():
#    xml = get_delicious_xml()
#    new_links = extract_items(xml)
    
    su = SeenURLs()
#     for i in new_links:
#         if not( su.been_seen(i['link']) ):
#             i['pubDate'] = datetime.now()
#             su.register(i)

#    render_html(su.links, '/home/wdr1/public_html/tasty/index.html')
#    render_xml(su.links, '/home/wdr1/public_html/tasty/index.xml')

    su.close()

if __name__ == "__main__":
    main()
