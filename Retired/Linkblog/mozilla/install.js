const APP_DISPLAY_NAME = "Linkblog";
const APP_NAME = "linkblog";
const APP_PACKAGE = "/William Reardon/linkblog";
const APP_VERSION = "0.2";

const APP_JAR_FILE = "linkblog.jar";
const APP_CONTENT_FOLDER = "content/linkblog/";
const APP_LOCALE_FOLDER  = "locale/en-US/linkblog/";

const APP_SUCCESS_MESSAGE = "Linkblog installed!\n\n";


initInstall(APP_NAME, APP_PACKAGE, APP_VERSION);

var chromef;

if(confirm("Install this into the application directory?  (Cancel will install into your profile directory)"))
  chromef = getFolder("Chrome");
else
  chromef = getFolder("Profile", "chrome");

var err = addFile(APP_PACKAGE, APP_VERSION, APP_JAR_FILE, chromef, null)
if(err == SUCCESS) { 
	var jar = getFolder(chromef, APP_JAR_FILE);
	registerChrome(CONTENT | DELAYED_CHROME, jar, APP_CONTENT_FOLDER);
	registerChrome(LOCALE  | DELAYED_CHROME, jar, APP_LOCALE_FOLDER);
	err = performInstall();
	if(err == SUCCESS | err == REBOOT_NEEDED) {
		alert(APP_NAME + " " + APP_VERSION + " has been succesfully installed.\n"
			+APP_SUCCESS_MESSAGE
			+"Please restart your browser before continuing.");
	} else { 
		alert("Install failed. Error code:" + err);
		cancelInstall(err);
	}
} else { 
	alert("Failed to create " +APP_JAR_FILE +"\n"
		+"You probably don't have appropriate permissions \n"
		+"(write access to phoenix/chrome directory). \n"
		+"_____________________________\nError code:" + err);
	cancelInstall(err);
}
