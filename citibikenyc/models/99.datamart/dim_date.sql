{{ config(materialized='table') }}   -- materializado como tabla (recomendado para dim_date)

WITH generador_de_fechas AS (
    SELECT range AS date_key
    FROM range(DATE '2024-01-01', DATE '2025-01-01', INTERVAL 1 DAY)
)

SELECT 
    date_key AS id,

    -- Día / Semana
    dayofyear(date_key)          AS day_of_year,
    yearweek(date_key)           AS week_key,           -- función nativa de DuckDB
    week(date_key)               AS week_of_year,
    dayofweek(date_key)          AS day_of_week,
    isodow(date_key)             AS iso_day_of_week,
    dayname(date_key)            AS day_name,
    date_trunc('week', date_key) AS first_day_of_week,
    date_trunc('week', date_key) + INTERVAL 6 DAY AS last_day_of_week,

    -- Mes
    (year(date_key) * 100 + month(date_key)) AS month_key,
    month(date_key)              AS month_of_year,
    day(date_key)                AS day_of_month,
    left(monthname(date_key), 3) AS month_name_short,
    monthname(date_key)          AS month_name,
    date_trunc('month', date_key) AS first_day_of_month,
    last_day(date_key)           AS last_day_of_month,

    -- Trimestre
    (year(date_key) * 10 + quarter(date_key))::INT AS quarter_key,
    quarter(date_key)            AS quarter_of_year,
    date_diff('day', date_trunc('quarter', date_key), date_key) + 1 AS day_of_quarter,
    'Q' || quarter(date_key)     AS quarter_desc_short,
    'Quarter ' || quarter(date_key) AS quarter_desc,
    date_trunc('quarter', date_key) AS first_day_of_quarter,
    last_day(date_trunc('quarter', date_key) + INTERVAL 2 MONTH) AS last_day_of_quarter,

    -- Año
    year(date_key)               AS year_key,
    date_trunc('year', date_key) AS first_day_of_year,
    date_trunc('year', date_key) + INTERVAL 1 YEAR - INTERVAL 1 DAY AS last_day_of_year,

    -- Orden del día dentro del mes por tipo de día
    row_number() OVER (
        PARTITION BY year(date_key), month(date_key), dayofweek(date_key)
        ORDER BY date_key
    ) AS ordinal_weekday_of_month

FROM generador_de_fechas
ORDER BY date_key