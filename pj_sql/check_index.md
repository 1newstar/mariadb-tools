# Common Use SQL - Index


* ## 查看哪些索引采用部分索引（前缀索引）
> 优化建议：检查部分索引长度是否还可以进一步缩小
```mysql
SELECT TABLE_SCHEMA, TABLE_NAME, INDEX_NAME,
SEQ_IN_INDEX, COLUMN_NAME, CARDINALITY, SUB_PART
FROM INFORMATION_SCHEMA.STATISTICS WHERE
SUB_PART > 10 ORDER BY SUB_PART DESC;
```

* ## 查看哪些索引长度超过30字节，重点查CHAR/VARCHAR/TEXT/BLOB等类型
> 优化建议：超过20字节长度的索引，都应该考虑进一步缩短，否则效率不佳
```mysql
select c.table_schema as `db`, c.table_name as `tbl`,
 c.COLUMN_NAME as `col`, c.DATA_TYPE as `col_type`,
 c.CHARACTER_MAXIMUM_LENGTH as `col_len`,
 c.CHARACTER_OCTET_LENGTH as `col_len_bytes`,
 s.NON_UNIQUE as `isuniq`, s.INDEX_NAME, s.CARDINALITY,
 s.SUB_PART, s.NULLABLE
 from information_schema.COLUMNS c inner join information_schema.STATISTICS s
 using(table_schema, table_name, COLUMN_NAME) where
 c.table_schema not in ('mysql', 'sys', 'performance_schema', 'information_schema', 'test') and
 c.DATA_TYPE in ('varchar', 'char', 'text', 'blob') and
 ((CHARACTER_OCTET_LENGTH > 20 and SUB_PART is null) or
 SUB_PART * CHARACTER_OCTET_LENGTH/CHARACTER_MAXIMUM_LENGTH >20);
```


* ## 检查哪些表没有显式创建主键索引
> 优化建议：
> - 选择自增列做主键；
> - 或者其他具备单调递增特点的列做主键；
> - 主键最好不要有业务用途，避免后续会更新。

```mysql
SELECT
a.TABLE_SCHEMA as `db`,
a.TABLE_NAME as `tbl`
FROM
(
SELECT
TABLE_SCHEMA,
TABLE_NAME
FROM
information_schema.TABLES
WHERE
TABLE_SCHEMA NOT IN (
'mysql',
'sys',
'information_schema',
'performance_schema'
) AND
TABLE_TYPE = 'BASE TABLE'
) AS a
LEFT JOIN (
SELECT
TABLE_SCHEMA,
TABLE_NAME
FROM
information_schema.TABLE_CONSTRAINTS
WHERE
CONSTRAINT_TYPE = 'PRIMARY KEY'
) AS b ON a.TABLE_SCHEMA = b.TABLE_SCHEMA
AND a.TABLE_NAME = b.TABLE_NAME
WHERE
b.TABLE_NAME IS NULL;
```

