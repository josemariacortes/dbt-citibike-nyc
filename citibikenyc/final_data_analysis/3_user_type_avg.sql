-- 3. Duración media del viaje por tipo de usuario
select
    user_type,
    avg(trip_duration_minutes) as avg_trip_duration

group by user_type
order by avg_trip_duration desc;
