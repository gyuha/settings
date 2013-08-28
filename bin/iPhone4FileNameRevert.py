#!/usr/bin/python
# -*- coding: utf-8 -*-
#####################################################################
# 실행 전에 이미지 라이브러리 설치 필요
# 	http://www.pythonware.com/products/pil/index.htm
# 이미지 라이브러리 설치 방법
#	python setup.py install
#####################################################################
import sys
import string
import os
import Image

def convertFile(dirpath, filename):
	path = dirpath+'/'+filename
	s =  os.path.splitext(path)
	if s[1] == '.png' and  path.find('@2x') > 0 :
		rename = path.replace('@2x', '')
		if os.path.exists(rename):
			print "Revert Filename : " + rename
			os.remove(rename)
			os.rename(path, rename)
			return 1
		return 0

convertCount = 0;
totalFileCount = 0;
for dirpath, dirnames, filenames in os.walk("."):
	if dirpath.find('.svn') > 0:
		continue
	for filename in filenames:
		if convertFile(dirpath, filename):
			convertCount = convertCount + 1
		totalFileCount = totalFileCount + 1
print '========================================'
print '   Total File(s) :'+str(totalFileCount)
print ' Convert File(s) :'+str(convertCount)
print '========================================'
