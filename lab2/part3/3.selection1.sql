-- Вывести информацию об квартирах (владельцы, адреса)
select owners."name", owners.last_name, buildings.street, buildings."number", apartaments."number" 
from apartaments
join owners on apartaments.owner_id = owners.id
join buildings on apartaments.building_id = buildings.id;