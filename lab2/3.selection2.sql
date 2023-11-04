-- Какие услуги и в каком количестве были выполнены в 2002 в порядке убывания количества выполнений
select service_types.id, service_types.description, count(payments.id)
from payments
join service_types on payments.service_type_id = service_types.id
where payments."period" between '2002.01.01' and '2002.12.02'
group by service_types.id
order by count desc;