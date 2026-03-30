-- 1. Las 10 estaciones con mayor número de viajes iniciados


select  
    t.start_station_id, 
    ds.station_name, 
    t.total_trips
from (
    select 
        start_station_id, 
        count(*) as total_trips
--    from {{ ref('fact_citibikenyc_trips') }}
    from fact_citibikenyc_trips        
    group by 1
    order by 2 desc
    limit 10
) as t
join dim_stations as ds
-- join {{ ref('dim_stations') }} as ds
    on ds.station_id = t.start_station_id
