#!/usr/bin/python
from selenium import selenium
import unittest, time
import random

# selenium functions
def login_process(website):
	sel = selenium("localhost", "4444", "*chrome", website)
	sel.start()
	sel.open_window(website,"google")
	sel.select_window("google")
	sel.set_timeout(120000)
	sel.window_maximize()
	sel.refresh()
	time.sleep(10)

	return sel

def do_stuff(sel):
	sel.type("q", "random")
	random_wait = random.randint(4,8)
	time.sleep(random_wait)
	sel.click("btnG")
	random_wait = random.randint(4,8)
	time.sleep(random_wait)
	return sel

def tearDown(sel):
	sel.stop()
	return sel
website = "http://www.google.com"

sel = login_process(website)
sel = do_stuff(sel)
tearDown(sel)

