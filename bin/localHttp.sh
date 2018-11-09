#!/bin/bash
PORT=9000

if [ ! -z "$1" ]; then
	PORT=$1
fi

python -m SimpleHTTPServer $PORT
