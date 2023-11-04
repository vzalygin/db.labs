-- Сколько потратил Аркадий Волож на оплату услуг для своих помещений
select sum(service_types.price_per_month)
from apartaments
join payments on payments.apartament_id = apartaments.id 
join service_types on payments.service_type_id = service_types.id 
where apartaments.owner_id = (
	select owners.id
	from owners
	where owners.name = 'Аркадий' and owners.last_name = 'Волож'
)
group by apartaments.owner_id;