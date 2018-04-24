#!/bin/bash
## Env: MariaDB 10.2

MYSQL='mysql -uroot'
MYSQLADMIN='mysqladmin -uroot'
MYSQLSHOW='mysqlshow -uroot'

echo
echo "Welcome to MySQL Server! Please make sure all of the check result is OK."
echo


echo "### Check DB Status ###"
echo "#1# Check DB is alive."
#mysqladmin --defaults-extra-file=healthcheck.cnf ping
${MYSQLADMIN} ping
echo
echo

echo "#2# Check DB Status."
${MYSQL} -e "\s"
echo
echo

echo "#3# Check DB Process."
${MYSQLADMIN} pr | egrep -v 'Sleep|\-\-\-\-\-' | sort -rn -k 12
echo
echo

echo "#4# Check InnoDB Engine Status."
# innodb status
${MYSQL} -e "show engine innodb status\G"
# latch 闩锁，分为mutex, rwlock. 用来保证并发线程操作临界资源的正确性
${MYSQL} -e "show engine innodb mutex;"
echo
echo

echo "#5# Check DB Query Cached."
${MYSQL} -e "show variables like '%query_cache%';"
${MYSQL} -e "show status like '%Qcache%';"
echo
echo