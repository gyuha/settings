#!/usr/bin/env python
# -*- coding:UTF-8 -*-
import sys, os
import zipfile
import ftplib

from os import path
from zipfile import ZipFile

##################################################################
# 내부 파일을 변경함.
def rezip( targetPath, filename):
	zip = ZipFile( filename, "a")
	tar = ZipFile( targetPath+"/"+filename, "w")
	i = 1
	for	f in zip.namelist():
		fileExt = os.path.splitext(f)[1]
		if	fileExt.upper() != ".JPG":
			continue
		zip.extract(f, targetPath)
		rename = '%04d'%i + os.path.splitext(targetPath+"/"+f)[1]
		os.rename( targetPath+"/"+f, rename)
		tar.write(rename)
		os.remove(rename)
		i = i + 1
	zip.close
	tar.close

def ftpUpload( targetPath):
	return


def isdir(ftp, name):
	try:
		ftp.cwd(name)
		ftp.cwd('..')
		return True
	except:
		return False


##################################################################
# 같은 패스 명을 만들기
targetPath = os.path.split(os.getcwd())[1]
if	not os.path.exists(targetPath):
	os.mkdir(targetPath)

print '압축을 새로 합니다.'
#모두 풀어 준다.
for filename in os.listdir(os.path.curdir):
	s = os.path.splitext(filename)
	if s[1] == ".zip" or s[1] == ".ZIP":
		print filename
		if not os.path.exists(targetPath+"/"+filename):
			rezip( targetPath, filename )

print '변환 완료'
print ''

##################################################################
# FTP에 연결 해서 파일을 올린다. 
if len(sys.argv) < 3:
	print '업로드 할 URL과 포트를 입력해 주세요'
	print '\t ex) '+sys.argv[0]+' 192.168.0.219 20000'
	exit(1)

ftp = ftplib.FTP()
ftp.connect(sys.argv[1], sys.argv[2])
print ftp.getwelcome()
if not isdir(ftp, targetPath):
	ftp.mkd( targetPath )
ftp.cwd( targetPath )

for filename in os.listdir(targetPath):
	print filename
	try:
		# File Upload
		fh = open(targetPath+"/"+filename, 'rb')
		ftp.storbinary('STOR '+filename, fh)
		fh.close()
	except:
		continue

ftp.quit()				# close FTP
