-- Переписать все квартиры Торвальдса Ван Россуму
update apartaments 
set owner_id = (select owners.id from owners where owners.last_name = 'Ван Россум')
where apartaments.owner_id = (select owners.id from owners where owners.last_name = 'Торвальдс');