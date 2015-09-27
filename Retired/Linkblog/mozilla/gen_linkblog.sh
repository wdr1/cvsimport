rm -f linkblog.jar linkblog.xpi
cd linkblog
find . -type f | grep -v CVS | perl -pe "s|^\./?||"  | xargs -n 1 zip linkblog.jar 
mv linkblog.jar ..
cd ..
zip linkblog.xpi linkblog.jar install.js
rm linkblog.jar

