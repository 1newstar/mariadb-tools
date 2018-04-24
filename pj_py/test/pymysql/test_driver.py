#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

try:
    import MySQLdb

    print("Import MySQL Driver: MySQLdb")

except ImportError as e:
    import pymysql

    print("Import MySQL Driver: pymysql")
    print(e)

finally:
    sys.exit(1)
