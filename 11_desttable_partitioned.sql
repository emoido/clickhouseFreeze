CREATE TABLE destdb.desttable_partitioned ON CLUSTER cluster_freeze
(
    `callsign` String,
    `number` String,
    `icao24` String,
    `registration` String,
    `typecode` String,
    `origin` String,
    `destination` String,
    `firstseen` DateTime,
    `lastseen` DateTime,
    `day` DateTime,
    `latitude_1` Float64,
    `longitude_1` Float64,
    `altitude_1` Float64,
    `latitude_2` Float64,
    `longitude_2` Float64,
    `altitude_2` Float64
)
