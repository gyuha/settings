#!/bin/bash
for folder in */
do
	7z a ${folder%/}{.7z,}
done
