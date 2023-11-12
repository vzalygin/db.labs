explain
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;

explain (ANALYZE)
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;

create index on apartaments (full_address);

explain
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;

explain (ANALYZE)
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;
