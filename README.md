# Freeze Example on ClickHouse Cluster
## Prerequisites
* Create 2 nodes cluster without replicas.
* Cluster name is "cluster_freeze".
* Configure cluster with the help of this [document](https://clickhouse.com/docs/en/guides/sre/keeper/clickhouse-keeper).
* OS User must have sudo privilege.

## Environment
* ClickHouse 22.9.3.18
* Ubuntu Linux 22.04.1 LTS

## Steps

* **Clone the repository to the every nodes on the cluster:**
```bash
git clone https://github.com/emoido/clickhouseFreeze.git
```

* **Go to the clickhouseFreeze directory**
```bash
cd clickhouseFreeze
```
* **Create database on cluster:** [01_createsourcedb.sql](https://github.com/emoido/clickhouseFreeze/blob/main/01_createsourcedb.sql)
```bash
clickhouse-client --password=your_password --queries-file "01_createsourcedb.sql"
```
	
* **Create partitioned table. This command must execute every nodes on the cluster:** [02_sourcetable_partitioned_local.sql](https://github.com/emoido/clickhouseFreeze/blob/main/02_sourcetable_partitioned_local.sql)
```bash
clickhouse-client --password=your_password --queries-file "02_sourcetable_partitioned_local.sql"
```

* **Create nonpartitioned table(This command must execute every nodes on the cluster):** [03_sourcetable_nonpartitioned_local.sql](https://github.com/emoido/clickhouseFreeze/blob/main/03_sourcetable_nonpartitioned_local.sql)
```bash
clickhouse-client --password=your_password --queries-file "03_sourcetable_nonpartitioned_local.sql"
```
*  **Create distributed partitioned table:** [04_sourcetable_partitioned.sql](https://github.com/emoido/clickhouseFreeze/blob/main/04_sourcetable_partitioned.sql)
```bash
clickhouse-client --password=your_password --queries-file "04_sourcetable_partitioned.sql"
```
*  **Create distributed nonpartitioned table:** [05_sourcetable_nonpartitioned.sql](https://github.com/emoido/clickhouseFreeze/blob/main/05_sourcetable_nonpartitioned.sql)
```bash
clickhouse-client --password=your_password --queries-file "05_sourcetable_nonpartitioned.sql"
```
* **Download sample dataset with the following command. In the scope of this test, We downloaded and used 4 months data, but you can download and install all data.**
```bash
wget -O- https://zenodo.org/record/5092942 | grep -oP 'https://zenodo.org/record/5092942/files/flightlist_\d+_\d+\.csv\.gz' | xargs wget
```
* **Insert data both partitioned and nonpartitioned tables**
```bash
ls -1 flightlist_*.csv.gz | xargs -P100 -I{} bash -c 'gzip -c -d "{}" | clickhouse-client --password=your_password --date_time_input_format best_effort --query "INSERT INTO sourcedb.sourcetable_nonpartitioned FORMAT CSVWithNames"'


ls -1 flightlist_*.csv.gz | xargs -P100 -I{} bash -c 'gzip -c -d "{}" | clickhouse-client --password=your_password --date_time_input_format best_effort --query "INSERT INTO sourcedb.sourcetable_partitioned FORMAT CSVWithNames"'
```
* **Freeze partitioned table.Run the following command on all nodes in the cluster. If you don't specify partition clause, it will backup all partitions:** [06_freezepartition.sql](https://github.com/emoido/clickhouseFreeze/blob/main/06_freezepartition.sql)
```bash
clickhouse-client --password=your_password --queries-file "06_freezepartition.sql"
```

* **Freeze nonpartitioned table.Run the following command on all nodes in the cluster:** [07_freezenonpartition.sql](https://github.com/emoido/clickhouseFreeze/blob/main/07_freezenonpartition.sql)
```bash
clickhouse-client --password=your_password --queries-file "07_freezenonpartition.sql"
```
* **For restore tests, created "destdb" on the same cluster:** [08_createdestdb.sql](https://github.com/emoido/clickhouseFreeze/blob/main/08_createdestdb.sql)
```bash
clickhouse-client --password=your_password --queries-file "08_createdestdb.sql"
```
* **Create local destination tables.Run the following commands on all nodes in the cluster:** 
[09_desttable_partitioned_local.sql](https://github.com/emoido/clickhouseFreeze/blob/main/09_desttable_partitioned_local.sql)
```bash
clickhouse-client --password=your_password --queries-file "09_desttable_partitioned_local.sql"
```
[10_desttable_nonpartitioned_local.sql](https://github.com/emoido/clickhouseFreeze/blob/main/10_desttable_nonpartitioned_local.sql)
```bash
clickhouse-client --password=your_password --queries-file "10_desttable_nonpartitioned_local.sql"
```
* **Create distributed destination tables:**
[11_desttable_partitioned.sql](https://github.com/emoido/clickhouseFreeze/blob/main/11_desttable_partitioned.sql)
```bash
clickhouse-client --password=your_password --queries-file "11_desttable_partitioned.sql"
```
[12_desttable_nonpartitioned.sql](https://github.com/emoido/clickhouseFreeze/blob/main/12_desttable_nonpartitioned.sql)
```bash
clickhouse-client --password=your_password --queries-file "12_desttable_nonpartitioned.sql"
```
* **Run the following command to copy freeze files to destination table's "detached" directory. This command must run every nodes in the cluster**
```bash
sudo su -c "./rsync.sh" root
```
* **For the partitioned table you can directly attach partition with the following command.Run the command on all nodes in the cluster:** 
```bash
clickhouse-client --password=your_password
```
```sql
ALTER TABLE destdb.desttable_partitioned_local
    ATTACH PARTITION 201903;
```
* For the nonpartitioned table run the following command on all nodes in the cluster.**
```bash
sudo su -c "./attachpart.sh default_users_password" root
```





