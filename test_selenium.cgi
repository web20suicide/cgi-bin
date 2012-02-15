#!/usr/bin/python
from selenium import selenium
import unittest, time, re
import os, sys
import random,cgi


	
# selenium functions
def login_process(website,query):
	sel = selenium("localhost", "4441", "*chrome", website)
	sel.start()
	random_wait = random.randint(4,5)
	time.sleep(random_wait)
	sel.open_window(website,"koobecaf")
	print "open website"
	sel.select_window("koobecaf")
	sel.set_timeout(120000)
	random_wait = random.randint(2,4)
	time.sleep(random_wait)
	sel.window_maximize()
	# go fullscreen by simulating F11 button press
	sel.key_press("//","\\122")
	sel.refresh()
	time.sleep(5)
	return sel

def tearDown(sel):
	sel.stop()
	return sel

website = "http://www.facebook.com"
query = "fuck"

sel = login_process(website,query)
tearDown(sel)
