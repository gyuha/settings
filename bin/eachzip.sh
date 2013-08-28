#!/bin/bash
for folder in */
do
	zip -r "${folder%/}.zip" "$folder"
done
