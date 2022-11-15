rsync -a /var/lib/clickhouse/shadow/source_partitioned_freeze/store/*/*/* /var/lib/clickhouse/data/destdb/desttable_partitioned_local/detached/
#
rsync -a /var/lib/clickhouse/shadow/source_nonpartitioned_freeze/store/*/*/* /var/lib/clickhouse/data/destdb/desttable_nonpartitioned_local/detached/
