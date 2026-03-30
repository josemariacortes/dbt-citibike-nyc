{{ config(materialized='table') }}

-- La tabla de viajes la generamos sin los campos utilizados para el cáclulo y añadimos la auditoria
WITH tmp_data AS (
    SELECT 
        ride_id
        ,member_casual
        ,rideable_type
        ,trip_distance_km
        ,trip_duration_minutes
        ,started_at
        ,ended_at
        ,start_station_id  
        ,end_station_id    
        -- campos de auditoria
        , NOW() audit_row_insert
        , 'dbt_demo' audit_process_id
    FROM
        {{ ref('stg_fact_citibikenyc_trips') }}
)
SELECT *
FROM tmp_data
