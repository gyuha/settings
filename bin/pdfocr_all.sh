#!/bin/bash
echo $1
#ocrmypdf -l eng+kor "$1"  "$1"
for f in *.pdf; do
	echo "#############################################"
	echo "OCR : $f"
	ocrmypdf -l eng+kor --pdfa-image-compression auto  "./$f"  "./$f"
	echo "################## DONE #####################"
done
