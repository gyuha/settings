#!/bin/bash

FILELIST="minify.$$.tmp"
PWD=`echo ~`
COMPORESSOR="$PWD/bin/yuicompressor-2.4.7.jar"

# Minify js or css files.
find . -type f -iname '*.css' -o -iname '*.js' | grep  -v .min. > $FILELIST
TOTAL=`wc -l < $FILELIST`
COUNT=0
while read LINE
do
    OLD="$LINE"
    NEW=` echo "$LINE" | sed 's/.css$/.min.css/g'`
    NEW=` echo "$NEW" | sed 's/.js$/.min.js/g'`
	COUNT=$((COUNT+1))
	echo "[$COUNT/$TOTAL] $OLD to $NEW"
    java -jar $COMPORESSOR $OLD -o $NEW
done < $FILELIST
rm -r $FILELIST
