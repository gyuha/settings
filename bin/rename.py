#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import string
import os
import shutil
import codecs

if len(sys.argv) is 1:
	print >> sys.stderr, '읽을 파일명을 입력해 주세요'
	print ''
	print '* 파일의 내용'
	print '\t[원본 파일명] [탭] [복사 할 파일명]'
	print ''
	print '* 사용예'
	print '\t./rename.py [목록 파일 이름]'
	exit(1)

try:
	f = codecs.open(sys.argv[1], "r", "utf-8") # 파일 오픈
except IOError:
	print >> sys.stderr, '그런 파일이 없거나, 열기 에러입니다.'
	exit(1)

topath = "rename"
if	os.path.exists(topath) == False:
	os.mkdir(topath, 0755)

for line in f.readlines():
	words = line.split('\t')
	strNum = words[0].strip()
	if strNum.startswith(u'\ufeff'):
		strNum = strNum[1:]
	strNum = "%03d"%int(strNum)
	src = strNum+".mp3"
	to = topath+"/"+words[1].strip()+".mp3"
	src = src.strip();
	to = to.strip();
	if os.path.isfile(src):
		print src + "-->"+ to
		shutil.copyfile(src, to)
	else:
		print src+" file not found";
