-- Check Galera Status
SHOW VARIABLES LIKE 'wsrep_osu_method';
SHOW VARIABLES LIKE 'wsrep_start_position';

SHOW STATUS LIKE 'wsrep%';
# SELECT *
# FROM information_schema.GLOBAL_STATUS
# WHERE VARIABLE_NAME LIKE 'wsrep_flow%'
#       OR VARIABLE_NAME IN
#          ('wsrep_cluster_status', 'wsrep_connected', 'wsrep_local_state_comment', 'wsrep_ready',
#           'wsrep_local_recv_queue', 'wsrep_local_send_queue', 'wsrep_received_bytes', 'wsrep_replicated_bytes');