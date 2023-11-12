create or replace function compute_sum_module(modu integer, lim integer)
returns integer as 
$$
declare 
	curs1 cursor for select payments.id, payments.price from payments;
	id uuid;
	price integer;
	res integer;
begin
	res = 0;
	while lim > 0 loop
		fetch curs1 into id, price;
		if id % modu = 0 then
			res = res + price;
		end if;
		lim = lim - 1;
	end loop;
	return res;
exception when others
then
	return -1;
end
$$
language 'plpgsql'
