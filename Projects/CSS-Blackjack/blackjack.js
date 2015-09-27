// $Id: blackjack.js,v 1.1.1.1 2010/08/14 04:57:49 wdr1 Exp $

var url = "blackjack.cgi"; // The server-side script
var deck_queue = new Array();
var http = getHTTPObject(); // We create the HTTP Object
// TODO: Tell user they have a browser we can't use if null

// Initialize the deck
function initDeckArray() {
  var p;
  try {
    p = new XMLHttpRequest();
  } catch (e) {
    p = new ActiveXObject("Msxml2.XMLHTTP");
  }
  p.open("GET", url + "?hw=2", false);
  p.send(null);
  deck_queue = p.responseText.split(":");
}


function reset() {
  var p;
  try {
    p = new XMLHttpRequest();
  } catch (e) {
    p = new ActiveXObject("Msxml2.XMLHTTP");
  }
  p.open("GET", url + "?a=reset", false);
  p.send(null);
  
  initDeckArray();
}

function handleHttpResponse() {
  if (http.readyState == 4) {
    // Split the comma delimited response into an array
    var r = http.responseText;
    test.innerHTML = deck_queue.shift();
    deck_queue.push( r );
    showShoe();
  }
}


function showLocalArray() {
  adump.innerHTML = deck_queue.join(" -- ");
}

function showShoe() {
  var p;
  try {
    p = new XMLHttpRequest();
  } catch (e) {
    p = new ActiveXObject("Msxml2.XMLHTTP");
  }
  p.open("GET", url + "?a=dump", false);
  p.send(null);
  shoe_dump.innerHTML = p.responseText;
}


function clickRight() {
  clicked("r");
}

function clickWrong() {
  clicked("w");
}

function clicked(action) {
  http.open("GET", url + "?a=" + action, true);
  http.onreadystatechange = handleHttpResponse;
  http.send(null);
}

function getHTTPObject() {
  var xmlhttp;
  /*@cc_on
  @if (@_jscript_version >= 5)
    try {
      xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
      try {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (E) {
        xmlhttp = false;
      }
    }
  @else
  xmlhttp = false;
  @end @*/
  if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
    try {
      xmlhttp = new XMLHttpRequest();
    } catch (e) {
      xmlhttp = false;
    }
  }
  return xmlhttp;
}


