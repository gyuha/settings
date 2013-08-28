#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import string
import re
import os
import threading

from collections import defaultdict

captureApplication = "./iOS-Simulator\ Cropper.app/Contents/MacOS/iOS-Simulator\ Cropper"
defaultPath = "."

def screenshotRun(filename):
	command_line = captureApplication + " -p 1 -f " + filename
	print command_line
	os.system(command_line)

def screenshot(filename, select_window=False, delay_s=0):
	t = threading.Timer(delay_s, screenshotRun, [defaultPath+"/%s" % filename])
	t.start()

def handle_line(line, count=defaultdict(int)):
	params = parse_line(line)
	if params:
		filebase, fileextension, once, delay_s = params
		if once and count[filebase] == 1:
			print 'Skipping taking %s screenshot, already done once' % filebase
		else:
			count[filebase] += 1
			number = count[filebase]
			count[None] += 1
			global_count = count[None]
			file_count_string = ('-%02d' % number) if not once else ''

			filename = '%02d.%s%s.%s' % (global_count, filebase, file_count_string, fileextension)
			print 'Taking screenshot: %s%s' % (filename, '' if delay_s == 0 else (' in %d seconds' % delay_s))
			screenshot(filename, select_window=False, delay_s=delay_s)

def parse_line(line):
	expression = r'.*screenshot\s*(?P<once>-once)?\s*(-delay\s*(?P<delay_s>\d*(\.?\d*)))?\s*(?P<filebase>\w+)?.?(?P<fileextension>\w+)?'
	m = re.match(expression, line)
	if m:
		params = m.groupdict()
		#print params
		filebase = params['filebase'] or 'screenshot'
		fileextension = params['fileextension'] or 'png'
		once = params['once'] is not None
		delay_s = float(params['delay_s'] or 0)
		print str(delay_s)
		return filebase, fileextension, once, delay_s
	else:
		#print 'Ignore: %s' % line
		return None

def main():
	try:
		while True:
			handle_line(raw_input())
	except (EOFError, KeyboardInterrupt):
		pass

if __name__ == '__main__':
	if len(sys.argv) > 1:
		print "default path : " + sys.argv[1]
		defaultPath = sys.argv[1]
		print defaultPath
	main()

