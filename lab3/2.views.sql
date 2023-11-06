create view apartaments_owners as
select apartaments.id, apartaments.full_address, apartaments.owner_id, owners."name" , owners.last_name 
from apartaments 
join owners on owners.id = apartaments.owner_id;
