#!/bin/bash
echo $1
ocrmypdf -l eng+kor "$1"  "$1"
