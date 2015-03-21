#!/bin/bash

mkdir drawable-{mdpi,hdpi,xhdpi,xxhdpi}

convert -resize 48x48 $1 drawable-mdpi/ic_launcher.png
convert -resize 72x72 $1 drawable-hdpi/ic_launcher.png
convert -resize 96x96 $1 drawable-xhdpi/ic_launcher.png
convert -resize 144x144 $1 drawable-xxhdpi/ic_launcher.png
tar cfz $$.tar.gz drawable-{mdpi,hdpi,xhdpi,xxhdpi}
echo Tarball available $$.tar.gz
rm -rf drawable-{mdpi,hdpi,xhdpi,xxhdpi}
