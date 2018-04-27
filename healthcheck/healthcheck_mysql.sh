#!/bin/bash
## Env: MariaDB 10.2

MYSQL='mysql -uroot'
MYSQLADMIN='mysqladmin -uroot'
#MYSQLADMIN='mysqladmin --defaults-extra-file=healthcheck.cnf'
MYSQLSHOW='mysqlshow -uroot'

echo
echo "Welcome to MySQL Server! Please make sure all of the check result is OK."
echo


echo "### Check DB Status ##########################################"
echo "# Check DB is alive ##########################################"
${MYSQLADMIN} ping
echo
echo

echo "# Check DB Base Status ########################################"
${MYSQL} -e "\s"
echo
echo

echo "# Check DB Directory #########################################"
DBDIR="basedir\|datadir\|tmpdir\|innodb_data_home_dir\|innodb_log_group_home_dir\|wsrep_data_home_dir"
${MYSQLADMIN} variables | grep ${DBDIR} | awk '{print $2,$4}'
echo
echo

echo "# Print Processlist ##########################################"
${MYSQLADMIN} pr | egrep -v 'Sleep|\-\-\-\-\-' | sort -rn -k 12
echo
echo

echo "# Check InnoDB Engine Status #################################"
# innodb status
${MYSQL} -e "show engine innodb status\G"
# latch 闩锁，分为mutex, rwlock. 用来保证并发线程操作临界资源的正确性
${MYSQL} -e "show engine innodb mutex;"
echo
echo

echo "# Check Query Cached #########################################"
${MYSQL} -e "show variables like '%query_cache%';"
${MYSQL} -e "show status like '%Qcache%';"
echo
echo

echo "### Check DB Health ##########################################"
echo "# Check Connection ###########################################"
## 连接数统计
##   - 最大用户连接
##   - 打开的连接
##   - 中止的连接
##   - 尝试失败的连接数
${MYSQLADMIN} variables | grep 'connections' | awk '{print $2,$4}'
${MYSQL} -e 'SHOW GLOBAL STATUS;' | grep 'Aborted_connects\|Access_denied_errors' | awk '{print $1,$2}'
echo
echo

# 线程数统计
#   - 缓冲内线程
#   - 线程缓冲大小
#
# 缓冲池统计
#
# 表锁统计
#   - 立即锁
#   - 等待锁
#   - 键效率#


echo "# The End ####################################################"