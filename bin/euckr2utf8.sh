#!/bin/bash
#example : find . -name *.java -exec ./euc2utf8.sh {} \;
echo $1
iconv -c -f euc-kr -t utf-8 $1 > $1.tmp && mv $1.tmp $
