-- Переписать все квартиры Воложа на Митника, а потом с Митника на Шулейко
-- read committed, repeatable read, serializable  
begin transaction isolation level read committed; 

with person1 as (select owners.id from owners where owners.last_name = 'Шулейко'),
     person2 as (select owners.id from owners where owners.last_name = 'Митник')
update apartaments set owner_id = (select id from person2) where owner_id = (select id from person1);

with person2 as (select owners.id from owners where owners.last_name = 'Митник'),
     person3 as (select owners.id from owners where owners.last_name = 'Волож')
update apartaments set owner_id = (select id from person3) where owner_id = (select id from person2);

commit;