# Common Use SQL - InnoDB


* ## 查看InnoDB表碎片率
> 优化建议：
```mysql
SELECT TABLE_SCHEMA as `db`, TABLE_NAME as `tbl`,
1-(TABLE_ROWS*AVG_ROW_LENGTH)/(DATA_LENGTH + INDEX_LENGTH + DATA_FREE) AS `fragment_pct`
FROM information_schema.TABLES WHERE
TABLE_SCHEMA = 'test' ORDER BY fragment_pct DESC;
```


* ## 查某个表在innodb buffer pool中的new block、old block比例
```mysql
select table_name, count(*), sum(NUMBER_RECORDS),
 if(IS_OLD='YES', 'old', 'new') as old_block from
 information_schema.innodb_buffer_page where
 table_name = '`test`.`t1`' group by old_block;
```

* ## InnoDB Buffer Pool 命中率
```
mysqladmin ext -uroot | grep -i innodb_buffer_pool
```

InnoDB缓存池命中率=(1-Innodb_buffer_pool_reads/Innodb_buffer_pool_read_requests)*100
