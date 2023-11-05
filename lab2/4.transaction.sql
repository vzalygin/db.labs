-- Создать нового владельца -- Кевин Митник; Переписать все квартиры Аркадия Воложа на Митника; Удалить Аркадия Воложа;
begin transaction isolation level read committed; -- read committed, repeatable read, serializable   

insert into owners 
values ('981c0b4d-225b-41da-b0f9-0f815476c919', 'Кевин', 'Митник');

update apartaments 
set owner_id = (select owners.id from owners where owners.name = 'Кевин' and owners.last_name = 'Митник')
where owner_id = (select owners.id from owners where owners.name = 'Линус' and owners.last_name = 'Торвальдс');

delete from owners
where owners.id = (select owners.id from owners where owners.name = 'Линус' and owners.last_name = 'Торвальдс');

commit;