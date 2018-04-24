
-- InnoDB每分钟产生的日志量

-- pager
pager grep -i "Log sequence number"
SHOW ENGINE innodb STATUS \G SELECT sleep(60); SHOW ENGINE innodb STATUS \G
nopager

SELECT round((@a2 - @a1) / 1024) AS KB;


-- InnoDB每分钟产生的日志量

-- information_schema.global_status
SELECT @a1 := variable_value AS a1
FROM information_schema.global_status
WHERE variable_name = 'Innodb_os_log_written'
UNION ALL
SELECT sleep(60)
UNION ALL
SELECT @a2 := variable_value AS a2
FROM information_schema.global_status
WHERE variable_name = 'Innodb_os_log_written';

SELECT round((@a2 - @a1) / 1024 / @@innodb_log_files_in_group) AS KB;
