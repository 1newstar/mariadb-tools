#!/usr/bin/env bash
## 2018/4/24

echo
echo "Welcome to MySQL Server, make sure all of the check result is OK"
echo


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
ps -eo pid,pcpu,size,rss,cmd | sort -rn -k 2 | head -n 6 | grep -iv 'PID.*CPU.*SIZE'
echo
echo


echo "#5# Check MySQL status."
mysqladmin -uroot --defaults-extra-file=healthcheck.cnf ping
mysqladmin -uroot pr | egrep -v 'Sleep|\-\-\-\-\-' | sort -rn -k 12 | head -n 6

