-- 2. Numero de viajes por parte del día
SELECT 
    t.part_of_day, 
    COUNT(*) AS trips
-- FROM {{ ref('fact_citibikenyc_trips') }} f
-- JOIN {{ ref('dim_time') }} t
   FROM fact_citibikenyc_trips f
   JOIN dim_time t    
    ON STRFTIME(f.started_at, '%H:%M') = t.ID
GROUP BY t.part_of_day
ORDER BY trips DESC



