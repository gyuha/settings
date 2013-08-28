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
#   http://appelfreelance.com/2011/07/python-2-7-os-x-lion-and-pil-_imaging-and-image/
#   위 사이트에서 v8c of jpeg를 받아서 컴파일 한다.
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
	if (s[1] == '.png' or s[1] == '.jpg') and  path.find('@2x') < 0:
		rename = s[0]+'@2x'+s[1]
		if os.path.exists(rename):
			return 0
		print path+'\t=>\t'+rename
		img = Image.open(path)
		img.save(rename, options='optimize')
		#img = img.resize((img.size[0] / 2, img.size[1] / 2), Image.BILINEAR)
		img = img.resize((img.size[0] / 2, img.size[1] / 2), Image.ANTIALIAS)
		os.remove(path)
		img.save(path, options='optimize')
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
