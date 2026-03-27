{{ 
    config(
        materialized='table',
        unique_key = 'station_id'
    )
}}

SELECT 
    start_station_id               AS station_id,
    ANY_VALUE(start_station_name)  AS station_name,
    AVG(start_lat)                 AS latitude,
    AVG(start_lng)                 AS longitude,
FROM {{ ref('cleaned_citibike_trips') }}
GROUP BY start_station_id
ORDER BY station_id