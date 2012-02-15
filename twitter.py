#!/usr/bin/python
from selenium import selenium
import unittest, time, re
import os, sys
import random,cgi

# selenium functions
def login_process(website):
	sel = selenium("localhost", "4441", "*chrome", website)
	sel.start()
	random_wait = random.randint(4,5)
	time.sleep(random_wait)
	sel.open_window(website,"twitter")
	sel.select_window("twitter")
	sel.set_timeout(120000)
	random_wait = random.randint(2,4)
	time.sleep(random_wait)
	sel.window_maximize()
	# go fullscreen by simulating F11 button press
	sel.key_press("//","\\122")
	sel.refresh()
	return sel

def do_something(sel):
	sel.type("username", "frescogamba")
	sel.click("password")
	sel.type("password", "trollface")
	sel.click("signin_submit")
	sel.wait_for_page_to_load("30000")
	time.sleep(4)
	sel.type("//div[@id='page-container']/div/div[1]/div[1]/div/div/div[2]/textarea", "....")
	sel.click("link=Tweet")
	print "done"
	return sel

def tearDown(sel):
	sel.stop()
	return sel

website = "http://www.twitter.com"

sel = login_process(website)
sel = do_something(sel)
