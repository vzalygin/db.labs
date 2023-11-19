explain
select *
from payments
join apartaments on apartaments.id = payments.apartament_id
where apartaments.full_address->>'street' = 'улица Льва Толстого' and payments.price > 3000;

explain (ANALYZE)
select *
from payments
join apartaments on apartaments.id = payments.apartament_id
where apartaments.full_address->>'street' = 'улица Льва Толстого' and payments.price > 3000;

QUERY PLAN                                                                                   |
---------------------------------------------------------------------------------------------+
Gather  (cost=30976.04..190505.86 rows=8704 width=311)                                       |
  Workers Planned: 2                                                                         |
  ->  Parallel Hash Join  (cost=29976.04..188635.46 rows=3627 width=311)                     |
        Hash Cond: (payments.apartament_id = apartaments.id)                                 |
        ->  Parallel Seq Scan on payments  (cost=0.00..156755.51 rows=725294 width=153)      |
              Filter: (price > 3000)                                                         |
        ->  Parallel Hash  (cost=29950.01..29950.01 rows=2083 width=158)                     |
              ->  Parallel Seq Scan on apartaments  (cost=0.00..29950.01 rows=2083 width=158)|
                    Filter: ((full_address ->> 'street'::text) = 'улица Льва Толстого'::text)|
JIT:                                                                                         |
  Functions: 14                                                                              |
  Options: Inlining false, Optimization false, Expressions true, Deforming true              |

QUERY PLAN                                                                                                                                    |
----------------------------------------------------------------------------------------------------------------------------------------------+
Gather  (cost=30976.04..190505.86 rows=8704 width=311) (actual time=243.628..1135.171 rows=215853 loops=1)                                    |
  Workers Planned: 2                                                                                                                          |
  Workers Launched: 2                                                                                                                         |
  ->  Parallel Hash Join  (cost=29976.04..188635.46 rows=3627 width=311) (actual time=209.860..1044.985 rows=71951 loops=3)                   |
        Hash Cond: (payments.apartament_id = apartaments.id)                                                                                  |
        ->  Parallel Seq Scan on payments  (cost=0.00..156755.51 rows=725294 width=153) (actual time=0.563..627.313 rows=722785 loops=3)      |
              Filter: (price > 3000)                                                                                                          |
              Rows Removed by Filter: 943882                                                                                                  |
        ->  Parallel Hash  (cost=29950.01..29950.01 rows=2083 width=158) (actual time=208.639..208.639 rows=33136 loops=3)                    |
              Buckets: 131072 (originally 8192)  Batches: 1 (originally 1)  Memory Usage: 20736kB                                             |
              ->  Parallel Seq Scan on apartaments  (cost=0.00..29950.01 rows=2083 width=158) (actual time=25.005..176.026 rows=33136 loops=3)|
                    Filter: ((full_address ->> 'street'::text) = 'улица Льва Толстого'::text)                                                 |
                    Rows Removed by Filter: 300198                                                                                            |
Planning Time: 0.235 ms                                                                                                                       |
JIT:                                                                                                                                          |
  Functions: 42                                                                                                                               |
  Options: Inlining false, Optimization false, Expressions true, Deforming true                                                               |
  Timing: Generation 3.057 ms, Inlining 0.000 ms, Optimization 11.432 ms, Emission 63.633 ms, Total 78.122 ms                                 |
Execution Time: 1147.079 ms                                                                                                                   |

create index on payments (price);

explain
select *
from payments
join apartaments on apartaments.id = payments.apartament_id
where apartaments.full_address->>'street' = 'улица Льва Толстого' and payments.price > 3000;

explain (ANALYZE)
select *
from payments
join apartaments on apartaments.id = payments.apartament_id
where apartaments.full_address->>'street' = 'улица Льва Толстого' and payments.price > 3000;

QUERY PLAN                                                                                   |
---------------------------------------------------------------------------------------------+
Gather  (cost=30976.04..193082.40 rows=9530 width=311)                                       |
  Workers Planned: 2                                                                         |
  ->  Parallel Hash Join  (cost=29976.04..191129.40 rows=3971 width=311)                     |
        Hash Cond: (payments.apartament_id = apartaments.id)                                 |
        ->  Parallel Seq Scan on payments  (cost=0.00..159068.67 rows=794165 width=153)      |
              Filter: (price > 3000)                                                         |
        ->  Parallel Hash  (cost=29950.01..29950.01 rows=2083 width=158)                     |
              ->  Parallel Seq Scan on apartaments  (cost=0.00..29950.01 rows=2083 width=158)|
                    Filter: ((full_address ->> 'street'::text) = 'улица Льва Толстого'::text)|
JIT:                                                                                         |
  Functions: 14                                                                              |
  Options: Inlining false, Optimization false, Expressions true, Deforming true              |

QUERY PLAN                                                                                                                                    |
----------------------------------------------------------------------------------------------------------------------------------------------+
Gather  (cost=30976.04..193082.40 rows=9530 width=311) (actual time=191.520..715.632 rows=215853 loops=1)                                     |
  Workers Planned: 2                                                                                                                          |
  Workers Launched: 2                                                                                                                         |
  ->  Parallel Hash Join  (cost=29976.04..191129.40 rows=3971 width=311) (actual time=176.612..662.595 rows=71951 loops=3)                    |
        Hash Cond: (payments.apartament_id = apartaments.id)                                                                                  |
        ->  Parallel Seq Scan on payments  (cost=0.00..159068.67 rows=794165 width=153) (actual time=0.060..263.736 rows=722785 loops=3)      |
              Filter: (price > 3000)                                                                                                          |
              Rows Removed by Filter: 943882                                                                                                  |
        ->  Parallel Hash  (cost=29950.01..29950.01 rows=2083 width=158) (actual time=175.970..175.971 rows=33136 loops=3)                    |
              Buckets: 131072 (originally 8192)  Batches: 1 (originally 1)  Memory Usage: 20736kB                                             |
              ->  Parallel Seq Scan on apartaments  (cost=0.00..29950.01 rows=2083 width=158) (actual time=13.873..152.083 rows=33136 loops=3)|
                    Filter: ((full_address ->> 'street'::text) = 'улица Льва Толстого'::text)                                                 |
                    Rows Removed by Filter: 300198                                                                                            |
Planning Time: 0.286 ms                                                                                                                       |
JIT:                                                                                                                                          |
  Functions: 42                                                                                                                               |
  Options: Inlining false, Optimization false, Expressions true, Deforming true                                                               |
  Timing: Generation 2.980 ms, Inlining 0.000 ms, Optimization 1.699 ms, Emission 39.975 ms, Total 44.655 ms                                  |
Execution Time: 728.135 ms                                                                                                                    |