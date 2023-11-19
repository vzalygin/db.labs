explain
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;

explain (ANALYZE)
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;

QUERY PLAN                                                               |
-------------------------------------------------------------------------+
Seq Scan on apartaments  (cost=0.00..43700.00 rows=333333 width=158)     |
  Filter: (((full_address ->> 'apartament_number'::text))::integer < 300)|

QUERY PLAN                                                                                                           |
---------------------------------------------------------------------------------------------------------------------+
Seq Scan on apartaments  (cost=0.00..43700.00 rows=333333 width=158) (actual time=0.062..327.899 rows=299709 loops=1)|
  Filter: (((full_address ->> 'apartament_number'::text))::integer < 300)                                            |
  Rows Removed by Filter: 700292                                                                                     |
Planning Time: 0.040 ms                                                                                              |
Execution Time: 339.606 ms                                                                                           |

create index on apartaments (full_address);

explain
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;

explain (ANALYZE)
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;

QUERY PLAN                                                               |
-------------------------------------------------------------------------+
Seq Scan on apartaments  (cost=0.00..43700.02 rows=333334 width=158)     |
  Filter: (((full_address ->> 'apartament_number'::text))::integer < 300)|

QUERY PLAN                                                                                                           |
---------------------------------------------------------------------------------------------------------------------+
Seq Scan on apartaments  (cost=0.00..43700.02 rows=333334 width=158) (actual time=0.031..324.752 rows=299709 loops=1)|
  Filter: (((full_address ->> 'apartament_number'::text))::integer < 300)                                            |
  Rows Removed by Filter: 700292                                                                                     |
Planning Time: 0.043 ms                                                                                              |
Execution Time: 336.084 ms                                                                                           |