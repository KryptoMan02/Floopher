#!/usr/bin/python3
from requests import put,post,get
from sys import argv
from os import getcwd

class Crawler:
	def __init__(self, url, cookie=None):
		self.url = url
		self.cookie = cookie
		self.method = input("What request method you wanna use ? ['GET', 'POST', 'PUT'] : ")
		self.file0 = open("big_rights_cms.txt")
		self.data0 = file0.readlines()

	def filterContent(self,response):
		page_resp = response.content.decode()
		for i in self.data0:
			if i[:-1] in page_resp:


	def crawler(self):
		if self.method in ('GET', 'Get', 'get'):
			resp = get(self.url)
			listOfCMSes = filterContent(resp)

url = argv[1]
obj = Crawler(url)
obj.crawler()
"""
user = input("Do you also wanna assign a Cookie ? [Y/n] ")
if user in "Yy":
	pass
else:
	pass
"""
