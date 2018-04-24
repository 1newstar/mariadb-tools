# check conn status
SELECT *
FROM information_schema.GLOBAL_VARIABLES
WHERE VARIABLE_NAME IN ('max_connections', 'host_cache_size', 'thread_cache_size');