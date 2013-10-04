#!/bin/bash
for folder in */
do
	tar -zcvf "${folder%/}.tar.gz" "$folder"
done
