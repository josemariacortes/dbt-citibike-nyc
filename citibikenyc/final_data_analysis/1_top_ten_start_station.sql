-- 1. Las 10 Estaciones con mayor número de viajes iniciados

SELECT start_station_name, COUNT(*) AS total_trips
-- FROM fact_citibikenyc_trips
from {{ ref('fact_citibikenyc_trips') }}
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
