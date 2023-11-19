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
