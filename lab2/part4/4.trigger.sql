-- Изменять стоимость налогов в соответствии с процентом налогов
create or replace function apply_taxes()
returns trigger as 
$$
begin 
	update service_types set price_per_month = price_per_month * 1.15
	where id = new.id;
	return new;
end;
$$
language 'plpgsql';

create trigger apply_taxes_trigger
after insert on service_types
for each row
execute function apply_taxes(); 

delete from service_types
where service_types.id = '8deda65a-816c-4d35-993a-a7de88158a53';

insert into service_types 
values ('8deda65a-816c-4d35-993a-a7de88158a53', 'Тестовая услуга', false, 1000);

select *
from service_types
where id = '8deda65a-816c-4d35-993a-a7de88158a53';