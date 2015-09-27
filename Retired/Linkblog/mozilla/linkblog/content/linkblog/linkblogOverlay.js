/* 
 *
 * Copyright (c) 2004 William Reardon
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 * 
 * Chunks of this were based on the "blogthis" module.  The rest was a ROYAL
 * pain in the ass.
 * 
 */

var linkBlogMenuItems = new Array("linkblog-sep", "linkblog-linkblog");

var LinkBlog = {
    init: function() {
        var menu = document.getElementById("contentAreaContextMenu");
        menu.addEventListener("popupshowing",LinkBlog.showHide,false);
    },

    showHide: function() {
        for(var i=0; i<linkBlogMenuItems.length; i++) {
            var menuitem = document.getElementById(linkBlogMenuItems[i]);
            if(menuitem) {
                menuitem.hidden = false;
            }
        }
    },

    getLink: function() {
    var elem = document.popupNode;
    while(elem) {
        if(elem instanceof Components.interfaces.nsIDOMHTMLAnchorElement && elem.href)
            return elem.href;
        elem = elem.parentNode;
    }
    return null;
  },

  getTitle: function( elem ) {
      var title;

      // First, find the link node
      while ( elem ) {
          if ( elem.nodeType == Node.ELEMENT_NODE ) {
              var localname = elem.localName.toUpperCase();
              if (localname == "A") {
                  break;
              }
          }
          elem = elem.parentNode;    
      }
      if ( ! elem.localName.toUpperCase() == "A") {
          alert("Couldn't find the actual link?!");
          return;
      }

      return elem.text;
  },

    openMyLinkblog: function(e) {
    var r = window.open("http://linkblog.org/linkblog.pl?a=my");
  },


    linkBlog: function(e) {
        var link, ref, title;

        //alert("link: " + gContextMenu.link);
        //        alert("tag: " + e.target.parentNode.href);
        
        var target = window.content.document;
        if (gContextMenu.onLink) {
            title = this.getTitle( gContextMenu.target );
            link  = gContextMenu.link;
            ref   = target.location.href;
        } else {
            link  = target.location.href;
            title = target.title;
            ref   = target.referrer;
        }
        
        link  = escape(link);
        ref   = escape(ref);
        title = escape(title);
        lb = window.open("http://linkblog.org/index.cgi?" +
        //        lb = window.open("http://wdr1.com/cgi-bin/dumper.cgi?" + 
                         "&nonav=1" + 
                         "&a=" + "sal" +
                         "&l=" + link +
                         "&r=" + ref +
                         "&t=" + title +
                         "",
                         "__linkblog_add",
                         'toolbar=0,statusbar= 0,location=0,menubar=0,resizable=1,width=415,height=200,left = 100,top = 100' );

    },
    
}

// do the init on load
window.addEventListener("load",LinkBlog.init, false); 

