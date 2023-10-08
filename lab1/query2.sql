select *, count( timezone ) over ( partition by timezone order by airport_code )
from airports_data;