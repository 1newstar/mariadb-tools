#!/bin/bash
## 2018/4/24

MYSQL='mysql -uroot'
MYSQLADMIN='mysqladmin -uroot'
MYSQLSHOW='mysqlshow -uroot'

echo
echo "Welcome to MySQL Server, make sure all of the check result is OK"
echo

echo "#1# Check OS Status."
echo "#1.1# Check who is login."
w
echo
echo

echo "#1.2# Check load of filesystem."
df -hT | grep -v 'Filesystem.*Type.*Size'|sort -rn -k 6|head -n 3
echo
echo

echo "#1.3# Check memory and swap."
echo "show memory & swap usage, check if memory leak"
free -h
echo
echo

echo "#1.4# Check which program load is high."
ps -eo pid,pcpu,size,rss,cmd | sort -rn -k 2 | head -n 11 | grep -iv 'PID.*CPU.*SIZE'
echo
echo


echo "#2# Check DB Status."
echo "#2.1# Check DB is alive."
#mysqladmin --defaults-extra-file=healthcheck.cnf ping
${MYSQLADMIN} ping
echo
echo

echo "#2.2# Check DB Status."
${MYSQL} -e "\s"
echo
echo

echo "#2.3# Check DB Process."
${MYSQLADMIN} pr | egrep -v 'Sleep|\-\-\-\-\-' | sort -rn -k 12
echo
echo

echo "#2.4# Check InnoDB Engine Status."
# innodb status
${MYSQL} -e "show engine innodb status\G"
# latch 闩锁，分为mutex, rwlock. 用来保证并发线程操作临界资源的正确性
${MYSQL} -e "show engine innodb mutex;"
echo
echo

echo "#2.5# Check DB Query Cached."
${MYSQL} -e "show variables like '%query_cache%';"
${MYSQL} -e "show status like '%Qcache%';"
echo
echo