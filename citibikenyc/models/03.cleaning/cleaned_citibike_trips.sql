{{ config(materialized='view') }}

-- descartamos posible duplicados y con valores nulos en campos clave
WITH removed_duplicates AS (
    SELECT DISTINCT
        *
    FROM
        {{ ref('stg_all_bikes') }}   
),

-- descartamos registros que no tengan origen o destino valido
error_od_id AS (
    SELECT
        *
    FROM
        removed_duplicates
    WHERE
        length(start_station_name) <> 0
        OR length(end_station_name) <> 0
)

-- descartamos fechas de viajes incorrectas
, error_fecha_viaje AS (
    SELECT
        *
    FROM
        error_od_id
    WHERE
        EXTRACT(YEAR FROM started_at) = 2024
        AND EXTRACT(YEAR FROM ended_at) = 2024
)
-- descartamos viajes con distancia 0   
, error_recorrido_viaje AS (
    SELECT
        *, SQRT(POWER(start_lat - end_lat, 2) + POWER(start_lng - end_lng, 2)) AS distance
    FROM
        error_fecha_viaje
    WHERE
        SQRT(POWER(start_lat - end_lat, 2) + POWER(start_lng - end_lng, 2)) <> 0
)

select * from error_recorrido_viaje
