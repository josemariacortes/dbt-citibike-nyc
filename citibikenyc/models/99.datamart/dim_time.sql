{{ config(materialized='table') }}
-- Generamos una tabla de dimensiones de tiempo con un registro por hora del día con su correspondiente hora
WITH TimeSeries AS (
    SELECT
        r.datetime_value::TIME AS ID,
        CASE
            WHEN EXTRACT(HOUR FROM r.datetime_value) < 6 THEN 'Night'
            WHEN EXTRACT(HOUR FROM r.datetime_value) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM r.datetime_value) < 18 THEN 'Afternoon'
            ELSE 'Evening'
        END AS part_of_day
    FROM range(
        TIMESTAMP '2024-01-01 00:00:00',
        TIMESTAMP '2024-01-01 23:59:59',
        INTERVAL 1 minute
    ) AS r(datetime_value)
)
SELECT * FROM TimeSeries
