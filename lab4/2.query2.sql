--Вывести все платежи по квартирам, которые находятся на Льва Толстого, где цена платежа больше 3000
select *
from payments
join apartaments on apartaments.id = payments.apartament_id
where apartaments.full_address->>'street' = 'улица Льва Толстого' and payments.price > 3000;
