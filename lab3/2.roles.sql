create role test login;

grant select on apartaments to test;
grant update on apartaments to test;
grant insert on apartaments to test;

grant select on payments to test;
grant update on payments to test;

grant select on owners to test;

grant update on apartaments_owners to public;

set role test;

insert into apartaments values ('92172a37-fe96-401a-af61-70f5bd77b583', 650, '{"street": "Новинский бульвар", "house_number": "8", "apartament_number": "650"}', '8cf1bf7d-4ba5-4adb-bd13-375fadb34a50', '9987a358-d888-4485-ab9a-099e40d4fa6b');
select * from apartaments where apartaments.id = '92172a37-fe96-401a-af61-70f5bd77b583';
update apartaments set building_id = '16b680b2-c024-4dfd-9398-a300ed0de319' where id = '92172a37-fe96-401a-af61-70f5bd77b583';
select * from apartaments where apartaments.id = '92172a37-fe96-401a-af61-70f5bd77b583';
delete from apartaments where id = '92172a37-fe96-401a-af61-70f5bd77b583'; -- не выполнится

select * from payments limit 1;
update payments set price = 0;
select * from payments limit 1;
insert into payments values ('0d84d078-96aa-41d3-a7ef-c56ea146a1ee', '2024-01-01', '2008-01-02', 0, '{471df453-c7fd-4929-b1e2-0075da2e3ee8,2819312b-78cf-4b50-9f49-c2f08dcd96e6,c6e2aa2a-af74-4018-b535-fde891a91d6d,13ff00bb-2200-4a92-947d-76016b63a1a3,94dd9137-5d06-43e7-a354-18320247ad57,aefd5ef9-e76a-4cbd-9a3e-3457d0fca314,e1647c18-3555-40cc-b864-a5856e288f47}', '72980dec-2249-4c15-a54a-8aef953782c6'); -- не выполнится

select * from owners;
update owners set name = 'Кевин' where name = 'Илья'; -- не выполнится
