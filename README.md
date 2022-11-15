# Freeze Example on ClickHouse Cluster
## Prerequisites
* Create 2 nodes cluster without replicas.
* Cluster name is "cluster_freeze".
* Configure cluster with the help of this [document](https://clickhouse.com/docs/en/guides/sre/keeper/clickhouse-keeper).

## Environment
* ClickHouse 22.9.3.18
* Ubuntu Linux 22.04.1 LTS

## Steps

* **Create database on cluster:** [01_createsourcedb.sql](https://github.com/emoido/clickhouseFreeze/blob/main/01_createsourcedb.sql)
* **Create partitioned table:** [02_sourcetable_partitioned_local.sql](https://github.com/emoido/clickhouseFreeze/blob/main/02_sourcetable_partitioned_local.sql)
* **Create nonpartitioned table:** [03_sourcetable_nonpartitioned_local.sql](https://github.com/emoido/clickhouseFreeze/blob/main/03_sourcetable_nonpartitioned_local.sql)


