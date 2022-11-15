


ls -1 flightlist_*.csv.gz | xargs -P100 -I{} bash -c 'gzip -c -d "{}" | clickhouse-client --password=your_password --date_time_input_format best_effort --query "INSERT INTO sourcedb.sourcetable_nonpartitioned FORMAT CSVWithNames"'
