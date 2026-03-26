{{ config(materialized='table') }}
-- Generamos una tabla con las estaciones, su geolocalización y su denominación

SELECT DISTINCT
    station_id,
    station_name,
    latitude,
    longitude
FROM (
    SELECT 
        start_station_id AS station_id,
        start_station_name AS station_name,
        start_lat AS latitude,
        start_lng AS longitude
    FROM enriched_citibikes_trips
    UNION
    SELECT 
        end_station_id AS station_id,
        end_station_name AS station_name,
        end_lat AS latitude,
        end_lng AS longitude
    FROM {{ ref('enriched_citibikes_trips') }}
) AS stations
