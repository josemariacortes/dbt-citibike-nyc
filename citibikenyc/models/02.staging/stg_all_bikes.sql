{{ config(materialized='view') }}

WITH citibike AS (
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
    FROM {{ ref('citibikenyc_trips') }}
    WHERE
        started_at is not null
        and ended_at is not null
        and start_station_id is not null
        and end_station_id is not null
),

citibike_jc AS (
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
    FROM {{ ref('citibikenyc_jc_trips') }}
    WHERE
        started_at is not null
        and ended_at is not null
        and start_station_id is not null
        and end_station_id is not null
)

SELECT * FROM citibike
UNION ALL
SELECT * FROM citibike_jc

AS stg_all_bikes
