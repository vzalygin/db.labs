with aircraft as (
	select aircraft_code, model, range, (range / 1000) * 1000 * 0.10 as reserve
	from aircrafts_data
)
--
select *, range-reserve as real_range 
from aircraft;