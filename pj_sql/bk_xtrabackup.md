# xtrabackup

## Usage

- backup
```bash
xtrabackup --defaults-file=/etc/my.cnf --backup --user='bkpuser' --password='bkpuser' --socket=mysql.sock /tmp/

xtrabackup --backup --target-dir=/data/backups --datadir=/data/mysql/
```

- recovery
```bash
xtrabackup --prepare --target-dir=/data/xtrabackup_backupfiles/

xtrabackup --defaults-file=/etc/my.cnf --copy-back --target-dir=/data/xtrabackup_backupfiles
```


## Reference

- https://www.percona.com/doc/percona-xtrabackup/LATEST/xtrabackup_bin/incremental_backups.html