{{ config(materialized='view') }}

WITH relevant_trips AS (
    SELECT *
    -- Duración del viaje en minutos
    , EXTRACT(MINUTE FROM age(ended_at, started_at)) AS trip_duration_minutes

    -- Distancia en km del punto inicio al punto fin usando la fórmula de Haversine.
    , ROUND(6371 * 2 * ASIN(SQRT(
        POWER(SIN(RADIANS(end_lat - start_lat) / 2), 2) +
        COS(RADIANS(start_lat)) * COS(RADIANS(end_lat)) *
        POWER(SIN(RADIANS(end_lng - start_lng) / 2), 2)
    )), 3) AS trip_distance_km

    FROM
        {{ ref('cleaned_citibike_trips') }}
)

SELECT
    *
FROM
    relevant_trips
