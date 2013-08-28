#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import string
import os


for filename in os.listdir("."):
	s =  os.path.splitext(filename)
	if s[1] == '.png' and  filename.find('@2x') < 0 :
		rename = s[0]+'@2x'+s[1]
		print filename+' to '+rename
		os.rename(filename, rename)
