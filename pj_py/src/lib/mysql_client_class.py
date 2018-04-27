#!/usr/bin/env python
# -*- coding: utf-8 -*-
import pymysql as mysql


class MySQL:
    def __int__(self, host, port, user, passwd, db, timeout, charset):
        self.host = host
        self.port = port
        self.user = user
        self.passwd = passwd
        self.db = db
        self.timeout = timeout
        self.charset = charset

    def get_conn(self, **kwargs):
        connect = mysql.connect(host=kwargs.get('host', 'localhost'),
                                port=kwargs.get('port', 3306),
                                user=kwargs.get('user'),
                                passwd=kwargs.get('password'),
                                db=kwargs.get('db'),
                                timeout=kwargs.get('timeout'),
                                charset=kwargs.get('charset'))
        return connect

    def flush_hosts(self, cursor):
        cursor.execute('flush hosts;')

    def get_mysql_status(self, cursor):
        data = cursor.execute('show global status;')
        data_list = cursor.fetchall()
        data_dict = {}
        for item in data_list:
            data_dict[item[0]] = item[1]
        return data_dict

    def get_mysql_variables(self, cursor):
        data = cursor.execute('show global variables;')
        data_list = cursor.fetchall()
        data_dict = {}
        for item in data_list:
            data_dict[item[0]] = item[1]
        return data_dict

    def get_mysql_version(self, cursor):
        cursor.execute('select version();')
        return cursor.fetchone()[0]

    def execute(self, sql, param):
        conn = mysql.connect(host=self.host, user=self.user, passwd=self.passwd, port=int(self.port),
                             timeout=int(self.timeout), charset=self.charset)
        conn.select_db(self.dbname)
        cursor = conn.cursor()
        if param != '':
            cursor.execute(sql, param)
        else:
            cursor.execute(sql)
        conn.commit()
        cursor.close()
        conn.close()

    def query(self, sql):
        conn = mysql.connect(host=self.host, user=self.user, passwd=self.passwd, port=int(self.port),
                             timeout=int(self.timeout), charset=self.charset)
        conn.select_db(self.dbname)
        cursor = conn.cursor()
        count = cursor.execute(sql)
        if count == 0:
            result = 0
        else:
            result = cursor.fetchall()
        return result
        cursor.close()
        conn.close()
