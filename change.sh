#!/bin/bash
# Changeip.com update script
# Based on a script by Ivan Bachvarov a.k.a SlaSerX
 
# Various variables, make sure to change the changeip.com credentials and hostname as required.
CIPUSER=yourchangeip_account@xxx.xxx
CIPPASS=PASSWORD_escaped_for_curl
CIPHOST=changeip_hostname
LOG="/var/log/changeip.log"
DATE=`date`
  
dns=`dig +short $CIPHOST`
current=`curl -s http://ip.changeip.com:8245|head -n1`
if [[ $dns != "$current" ]]; then 
  # changeip update now
  curl -s "https://nic.changeip.com/nic/update?ip=$current&u=$CIPUSER&p=$CIPPASS&hostname=$CIPHOST"
 
  # Print OLD vs New Comparision for REVIEW
  echo Old IP = $dns
  echo New IP = $current
  echo Update Time = $DATE
  echo Update Done.
 
  # Print OLD vs New Comparision for REVIEW in LOG FILE for later review
  echo "*********************************************"  >> $LOG
  echo New IP FOUND > $LOG
  echo Old IP = $dns >> $LOG
  echo New IP found at $DATE and IP is = $current >> $LOG 
fi
