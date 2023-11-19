-- Удалить все квартиры, затраты по которым больше 200k
delete from apartaments 
where apartaments.id in (
	select id
	from (
		select apartaments.id, sum(service_types.price_per_month) 
		from apartaments
		join payments on payments.apartament_id = apartaments.id 
		join service_types on service_types.id = payments.service_type_id 
		group by apartaments.id
	)
	where sum > 200_000
);