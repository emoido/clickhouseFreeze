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
* **Create partitioned table(This command must execute every nodes on the cluster):** [02_sourcetable_partitioned_local.sql](https://github.com/emoido/clickhouseFreeze/blob/main/02_sourcetable_partitioned_local.sql)
* **Create nonpartitioned table(This command must execute every nodes on the cluster):** [03_sourcetable_nonpartitioned_local.sql](https://github.com/emoido/clickhouseFreeze/blob/main/03_sourcetable_nonpartitioned_local.sql)
*  **Create distributed partitioned table:** [04_sourcetable_partitioned.sql](https://github.com/emoido/clickhouseFreeze/blob/main/04_sourcetable_partitioned.sql)
*  **Create distributed nonpartitioned table:** [05_sourcetable_nonpartitioned.sql](https://github.com/emoido/clickhouseFreeze/blob/main/05_sourcetable_nonpartitioned.sql)


