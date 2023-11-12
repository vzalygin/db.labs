-- Какие квартиры имеют номер < 300
explain
select *
from apartaments
where cast(full_address->>'apartament_number' as integer) < 300;
