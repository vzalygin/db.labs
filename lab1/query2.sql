-- Аэропорты с их количеством в каждой временной зоне отсортированные
select *, count( timezone ) over ( partition by timezone order by airport_code )
from airports_data
order by count desc;