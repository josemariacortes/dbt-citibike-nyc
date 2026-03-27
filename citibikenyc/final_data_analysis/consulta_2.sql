SELECT dim_time.part_of_day, COUNT(*) AS trips
FROM fact_citibikenyc_trips f
JOIN dim_time ON f.start_time = dim_time.id
GROUP BY 1
ORDER BY 2 DESC;
