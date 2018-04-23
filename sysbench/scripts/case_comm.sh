#!/bin/bash

CASE=$1
THREADS=$2

ARGS_MYSQL="--db-driver=mysql \
--mysql_storage_engine=innodb \
--mysql-host=localhost \
--mysql-port=3306 \
--mysql-user=root \
--mysql-password= \
--mysql-db=oltpdb \
--mysql-socket=/data/mysql/mysql.sock"
ARGS_COMM="--report-interval=1 --time=300"
ARGS_OLTP="--tables=100 --table_size=20000"
# OLTP_RW
ARGS_LUA="/opt/mariadb-tools/sysbench/share/sysbench/oltp_read_write.lua"

ARGS="${ARGS_LUA} ${ARGS_OLTP} ${ARGS_MYSQL} ${ARGS_COMM}"


# sysbench --db-driver=mysql --mysql_storage_engine=innodb --mysql-host=localhost --mysql-port=3306 --mysql-user=root --mysql-password= --mysql-db=oltpdb --mysql-socket=/var/lib/mysql/mysql.sock --report-interval=1 --time=300 --tables=100 --table_size=20000 /opt/mariadb-tools/sysbench/share/sysbench/oltp_read_write.lua prepare

echo "case ${CASE} start at `date +%Y%m%d_%H%M%S`"

sysbench $ARGS prepare
sysbench $ARGS --threads=${THREADS} run
sysbench $ARGS cleanup

echo "case ${CASE} end at `date +%Y%m%d_%H%M%S`"