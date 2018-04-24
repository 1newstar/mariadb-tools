# Common Use SQL - Trx


* ## 查看未完成的事务列表
> 优化建议：若有长时间未完成的事务，可能会导致：
> - undo不能被及时purge，undu表空间不断增长；
> - 持有行锁，其他事务被阻塞。
> 应该及时提交或回滚这些事务，或者直接kill释放之。

```mysql
select b.host, b.user, b.db, b.time, b.COMMAND,
 a.trx_id, a. trx_state from
 information_schema.innodb_trx a left join
 information_schema.PROCESSLIST b on a.trx_mysql_thread_id = b.id;
```

