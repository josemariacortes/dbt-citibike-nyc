-- 3. Duración media del viaje por tipo de usuario
select
    rideable_type,
    avg(trip_duration_minutes) as avg_trip_duration,
    avg(trip_distance_km) as avg_trip_distance
from fact_citibikenyc_trips
-- FROM {{ ref('fact_citibikenyc_trips') }}
group by rideable_type
order by rideable_type desc