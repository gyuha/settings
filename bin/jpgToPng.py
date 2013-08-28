#!/usr/bin/python
# -*- coding: utf-8 -*-
#####################################################################
# iPhone 4 용 이미지 파일 리사이징
# 실행 전에 이미지 라이브러리 설치 필요
# 	http://www.pythonware.com/products/pil/index.htm
#
# 이미지 라이브러리 설치 방법
#	python setup.py install
#
# XCODE 4 이상에서 설치
#   easy_install pip
#   ARCHFLAGS="-arch i386 -arch x86_64" pip install PIL
#####################################################################
import sys
import string
import os
import Image

def convertFile(dirpath, filename):
	path = dirpath+'/'+filename
	s =  os.path.splitext(path)
	if s[1] == '.jpg':
		rename = s[0]+'.png'
		if os.path.exists(rename):
			return 0
		print path+'\t=>\t'+rename
		img = Image.open(path)
		img.save(rename, options='optimize')
		return 1

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
