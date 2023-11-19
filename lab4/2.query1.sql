-- Какие квартиры имеют номер < 300
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;

--Вывести все платежи по квартирам, которые находятся на Льва Толстого, где цена платежа больше 3000
select *
from payments
join apartaments on apartaments.id = payments.apartament_id
where apartaments.full_address->>'street' = 'улица Льва Толстого' and payments.price > 3000;
