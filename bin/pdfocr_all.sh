#!/bin/bash
# 먼저 아래 프로그램을 설치 해야 한다.
#  - https://github.com/jbarlow83/OCRmyPDF
echo $1
#ocrmypdf -l eng+kor "$1"  "$1"
for f in *.pdf; do
	echo "#############################################"
	echo "OCR : $f"
	ocrmypdf -l eng+kor -v 0 -O 1 --skip-text "./$f"  "./$f"
	echo "################## DONE #####################"
done
