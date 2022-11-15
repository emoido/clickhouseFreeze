if [[ $# -ne 1 ]];then
	echo "Please enter clickhouse password as parameter"
	exit 111;
fi

PASSWORD=$1
for i in $(ls -l /var/lib/clickhouse/data/destdb/desttable_nonpartitioned_local/detached|grep all|awk '{print $9}');do
       	echo "alter table destdb.desttable_nonpartitioned_local attach part '$i'">attachpart_${i}.sql
	clickhouse-client --password=$PASSWORD --queries-file "attachpart_${i}.sql"
	rm attachpart_${i}.sql
done
