SHOW PLUGINS;

##### metadata_lock_info #####
# INSTALL SONAME 'metadata_lock_info';
SHOW metadata_lock_info;

SELECT CONCAT('Thread ', P.ID, ' executing "', P.INFO, '" IS LOCKED BY Thread ', M.THREAD_ID) WhoLocksWho
FROM INFORMATION_SCHEMA.PROCESSLIST P, INFORMATION_SCHEMA.METADATA_LOCK_INFO M
WHERE LOCATE(lcase(LOCK_TYPE), lcase(STATE)) > 0;

##### wsrep_info #####
# INSTALL SONAME 'wsrep_info';
# https://mariadb.com/kb/en/library/wsrep_info-plugin/
SHOW WSREP_STATUS;
SHOW WSREP_MEMBERSHIP;

SHOW STATUS LIKE 'wsrep%';
SHOW TABLES FROM information_schema
LIKE 'WSREP%';
SELECT *
FROM information_schema.WSREP_MEMBERSHIP;
SELECT *
FROM information_schema.WSREP_STATUS\G
