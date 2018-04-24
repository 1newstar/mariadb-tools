#!/usr/bin/env python
# -*- coding: utf-8 -*-
import pymysql as mysql


def get_conn(**kwargs):
    return mysql.connect(host=kwargs.get('host', 'localhost'),
                         user=kwargs.get('user'),
                         passwd=kwargs.get('password'),
                         port=kwargs.get('port', 3306),
                         db=kwargs.get('db'))


def exc_sql(conn, sql):
    with conn as cur:
        cur.execute(sql)


def main():
    conn = get_conn(host='192.168.52.151',
                    port=3306,
                    user='sbtest',
                    password='sbtest',
                    db='sbtest')

    try:
        # get cursor object
        with conn as cur:
            cur.execute("select now()")
            rows = cur.fetchall()
            for row in rows:
                print(row)

    finally:
        # close resources
        if conn:
            conn.close()


if __name__ == '__main__':
    main()
