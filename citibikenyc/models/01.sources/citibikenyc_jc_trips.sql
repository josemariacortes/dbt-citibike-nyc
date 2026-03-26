{{ config(materialized='view') }}   -- o 'table' si quieres persistir físicamente

SELECT
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual
FROM read_csv_auto(
    '/dbt_project/citibikenyc/data/JC-202405-citibike-tripdata.csv',
    header = true,
    delim = ',',
    types = {
        'ride_id'           : 'VARCHAR',
        'rideable_type'     : 'VARCHAR',
        'started_at'        : 'TIMESTAMP',
        'ended_at'          : 'TIMESTAMP',
        'start_station_name': 'VARCHAR',
        'start_station_id'  : 'VARCHAR',
        'end_station_name'  : 'VARCHAR',
        'end_station_id'    : 'VARCHAR',
        'member_casual'     : 'VARCHAR',
        -- Solo estas 4 columnas como números enteros de gran tamaño
        'start_lat'         : 'DECIMAL(38, 10)',
        'start_lng'         : 'DECIMAL(38, 10)',
        'end_lat'           : 'DECIMAL(38, 10)',
        'end_lng'           : 'DECIMAL(38, 10)'
    }
)