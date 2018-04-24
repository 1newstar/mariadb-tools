# Common Use SQL - Metadata


* ## 查看表数据列元数据信息
```mysql
select a.table_id, a.name, b.name, b.pos, b.mtype, b.prtype, b.len from
information_schema.INNODB_SYS_TABLES a left join
information_schema.INNODB_SYS_COLUMNS b
using(table_id) where a.name like 'test%';
```
