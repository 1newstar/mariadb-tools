#!/bin/bash

CASE=$1
THREADS=$2

ARGS_MYSQL="--db-driver=mysql --mysql_storage_engine=innodb --mysql-host=localhost --mysql-port=3309 --mysql-user=root --mysql-password= --mysql-db=oltpdb --mysql-socket=/${MYSID}/datadg/mysql.sock"
ARGS_COMM="--report-interval=1 --time=300"
ARGS_OLTP="--tables=100 --table_size=20000"
# OLTP_RW
ARGS_LUA="/opt/maria10.1/sysbench/share/sysbench/oltp_read_write.lua"

ARGS="${ARGS_LUA} ${ARGS_OLTP} ${ARGS_MYSQL} ${ARGS_COMM}"


echo "case ${CASE} start at `date +%Y%m%d_%H%M%S`"

sysbench $ARGS prepare
sysbench $ARGS --threads=${THREADS} run
sysbench $ARGS cleanup

echo "case ${CASE} end at `date +%Y%m%d_%H%M%S`"