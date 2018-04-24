#!/bin/bash
## Env: el7


echo
echo "Welcome to MySQL Server! Please make sure all of the check result is OK."
echo

echo "### Check OS Status ###"
echo "#1# Check who is login."
w
echo
echo

echo "#2# Check load of filesystem."
df -hT | grep -v 'Filesystem.*Type.*Size'|sort -rn -k 6|head -n 3
echo
echo

echo "#3# Check memory and swap."
echo "show memory & swap usage, check if memory leak"
free -h
echo
echo

echo "#4# Check which program load is high."
ps -eo pid,pcpu,size,rss,cmd | sort -rn -k 2 | head -n 11 | grep -iv 'PID.*CPU.*SIZE'
echo
echo

echo "#5# Check time sync by ntp."
systemctl status ntpd
ntpq -p
echo
echo

echo "# The End ####################################################"