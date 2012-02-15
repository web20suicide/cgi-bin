#!/bin/bash

# read the current id 
JOBID=$1

java -jar /usr/lib/cgi-bin/selenium-server-standalone-2.19.0.jar -port ${JOBID} -interactive -log "/tmp/selenium${JOBID}.log"
#java -jar /usr/lib/cgi-bin/selenium-server1_0_3.jar -port ${JOBID} -interactive -forcedBrowserMode "*firefox /usr/lib/firefox-10.0.1/" -log "/tmp/selenium${JOBID}.log"
