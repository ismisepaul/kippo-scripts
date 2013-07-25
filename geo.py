#!/usr/bin/env python

'''
This script utilises freegeoip.net to geo locate a country by ip address
The result will then be added to a custom mysql table in kippo db called geo
sqlCusTables/createGeoTable.sql
'''

import sys, subprocess
import re
import urllib, json
import MySQLdb as mdb

#CONNECT TO DB
con = mdb.connect('localhost', '<username>', '<password>', '<database>')

#Create a cursor
cur = con.cursor()
#Execute mysql query to get all IPs in sessions table that are not in geo (NEW IPs)
cur.execute("SELECT DISTINCT sessions.ip FROM sessions WHERE sessions.ip NOT IN (SELECT geo.ip FROM geo);")
#cur.execute("SELECT DISTINCT sessions.ip FROM sessions")
#Fetch all the results from the query
result=cur.fetchall()


#ITERATE THROUGH RESULTS FROM QUERY 
#SEND IP TO WEB SERVICE
for ip in result:
       	response = urllib.urlopen('http://freegeoip.net/json/%s' % (ip[0])).read()
	#print ip[0]	
	try:
		json_data = json.loads(response)
		#print(ip, json_data['city'], json_data['country_name'], json_data['longitude'], json_data['latitude'])
		
		cit = json_data['city']
		country = json_data['country_name']
		long = json_data['latitude']
		lat = json_data['longitude']

	#INSERT THE DATA INTO THE DB	
		with con:
			cur = con.cursor()
			cur.execute("INSERT IGNORE INTO geo VALUES('%s', '%s', '%s', '%s', '%s')" % (ip[0], cit, country, long, lat))
	#CATCH EXCEPTION IF IP CANNOT BE GEO LOCATED BY WEBSERVICE
	except ValueError:
		#print ('Error, the IP could not be located by the service')
		with con:
			cur = con.cursor()
			cur.execute("INSERT IGNORE INTO geo VALUES('%s', '%s', '%s', '%s', '%s')" % (ip[0], 'NOT_LOCATED', 'NOT_LOCATED', '0', '0'))
