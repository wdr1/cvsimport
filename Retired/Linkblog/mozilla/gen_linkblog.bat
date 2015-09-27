cd "C:\Documents and Settings\wdr1\Desktop\xpi\linkblog"
del linkblog.jar ../linkblog.xpi
cd linkblog
c:\cygwin\bin\find | perl -pe "s|^\./?||"  | zip linkblog.jar -@
move linkblog.jar ..
cd .. 
zip linkblog.xpi linkblog.jar install.js
move linkblog.xpi ..
cd ..

