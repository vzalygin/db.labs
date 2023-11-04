-- Удалить все платежи за 2017 год
delete from payments
where payments.payment_date between '2017-01-01' and '2018-01-01';