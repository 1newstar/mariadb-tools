# Common Use SQL - Lock


* ## 查看当前有无行锁等待事件
> 优化建议：
> - 若当前有行锁等待，则有可能导致锁超时被回滚，事务失败；
> - 有时候，可能是因为某个终端/会话开启事务，对数据加锁后，忘记提交/回滚，导致行锁不能释放。

```mysql
SELECT lw.requesting_trx_id AS request_XID,
 trx.trx_mysql_thread_id as request_mysql_PID,
 trx.trx_query AS request_query,
 lw.blocking_trx_id AS blocking_XID,
 trx1.trx_mysql_thread_id as blocking_mysql_PID,
 trx1.trx_query AS blocking_query, lo.lock_index AS lock_index FROM
 information_schema.innodb_lock_waits lw INNER JOIN
 information_schema.innodb_locks lo
 ON lw.requesting_trx_id = lo.lock_trx_id INNER JOIN
 information_schema.innodb_locks lo1
 ON lw.blocking_trx_id = lo1.lock_trx_id INNER JOIN
 information_schema.innodb_trx trx
 ON lo.lock_trx_id = trx.trx_id INNER JOIN
 information_schema.innodb_trx trx1
 ON lo1.lock_trx_id = trx1.trx_id;
```
其实，在MySQL 5.7下，也可以直接查看 sys.innodb_lock_waits 视图：
```mysql
SELECT * FROM sys.innodb_lock_waits\G
```


* ## 查看表数据列元数据信息
```mysql
select a.table_id, a.name, b.name, b.pos, b.mtype, b.prtype, b.len from
information_schema.INNODB_SYS_TABLES a left join
information_schema.INNODB_SYS_COLUMNS b
using(table_id) where a.name = 'test/t1';
```
