# Common Use SQL - Lock


* ## 查看当前InnoDB锁等待情况
```mysql
SELECT r.trx_id waiting_trx_id,
r.trx_mysql_thread_id waiting_thread,
left(r.trx_query,20) waiting_query, -- this is real
concat(concat(lw.lock_type, ' '), lw.lock_mode) waiting_for_lock,
b.trx_id blocking_trx_id,
b.trx_mysql_thread_id blocking_thread,
left(b.trx_query,20) blocking_query, -- this is just current
concat(concat(lb.lock_type, ' '), lb.lock_mode) blocking_lock
FROM information_schema.innodb_lock_waits w
INNER JOIN information_schema.innodb_trx b ON b.trx_id = w.blocking_trx_id
INNER JOIN information_schema.innodb_trx r ON r.trx_id = w.requesting_trx_id
INNER JOIN information_schema.innodb_locks lw ON lw.lock_trx_id = r.trx_id
INNER JOIN information_schema.innodb_locks lb ON lb.lock_trx_id = b.trx_id;


SELECT distinct
b.trx_id blocking_trx_id,
b.trx_mysql_thread_id blocking_thread,
left(b.trx_query,20) blocking_query, -- this is just current
concat(concat(lb.lock_type, ' '), lb.lock_mode) blocking_lock,
now() - trx_started blocking_time_sec
FROM information_schema.innodb_lock_waits w
LEFT JOIN information_schema.innodb_lock_waits r on w.blocking_trx_id = r.requesting_trx_id
INNER JOIN information_schema.innodb_trx b ON b.trx_id = w.blocking_trx_id
INNER JOIN information_schema.innodb_locks lb ON lb.lock_trx_id = b.trx_id
where r.requested_lock_id is null;

```


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
