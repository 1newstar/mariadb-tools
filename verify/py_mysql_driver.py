#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

try:
    import pymysql

    print("MySQL python driver is ok!")

except Exception as e:
    print(e)
    sys.exit(1)

finally:
    sys.exit(1)
