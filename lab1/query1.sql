-- Билеты с стоимостью с учетом скидки
SELECT amount, ROUND ((amount / 100), 2) * 30 as sale, amount - ROUND ((amount / 100), 2) * 30 as price 
FROM ticket_flights 
LIMIT 100;