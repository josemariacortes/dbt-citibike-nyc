-- 2. Numero de viajes por parte del día
SELECT dim_time.part_of_day, COUNT(*) AS trips
FROM fact_citibikenyc_trips f
-- FROM {{ ref('fact_citibikenyc_trips') }} F
JOIN dim_time ON f.start_time = dim_time.id
GROUP BY 1
ORDER BY 2 DESC;


