#!/bin/python3

import random

def uuid():
    import uuid
    return str(uuid.uuid4())

choice = random.choice
rand_range = random.randrange
to_calendar = lambda x: str(100+x)[1:]

def make_owners():
    class owner():
        def __init__(self, name, last_name) -> None:
            self.id = uuid()
            self.name = name
            self.last_name = last_name

        def insert_query(self):
            return f"INSERT INTO public.owners VALUES ('{self.id}', '{self.name}', '{self.last_name}');"
        
    return [
        owner("Аркадий", "Волож"),
        owner("Илья", "Сегалович"),
        owner("Тигран", "Худавердян"),
        owner("Даниил", "Шулейко"),
        owner("Григорий", "Дергачев"),
        owner("Елена", "Бунина"),
        owner("Грег", "Абовский"),
        owner("Линус", "Торвальдс"),
        owner("Гвидо", "Ван Россум"),
        owner("Ричард", "Столлман"),
    ]

def make_buildings():
    class building():
        def __init__(self, street, number) -> None:
            self.id = uuid()
            self.street = street
            self.number = number

        def insert_query(self):
            return f"INSERT INTO public.buildings VALUES ('{self.id}', '{self.street}', '{self.number}');"
    
    return [
        building("улица Льва Толстого", 16),
        building("Новинский бульвар", 8),
        building("Садовническая улица ", 82),
        building("1-й Красногвардейский проезд", 21),
        building("улица Косыгина", 15),
        building("Ленинградский проспект", 39),
        building("2-я Бауманская", 5),
        building("Рубцовская набережная", 2),
        building("Госпитальный переулок", 10),
        building("Лефортовская набережная", 1)
    ]

def make_apartaments(owners, buildings):
    class apartament():
        def __init__(self, number, building, owner) -> None:
            self.id = uuid()
            self.number = number
            self.building_id = building.id
            self.owner_id = owner.id

        def insert_query(self):
            return f"INSERT INTO public.apartaments VALUES ('{self.id}', '{self.number}', '{self.building_id}', '{self.owner_id}');"

    return list(set(
        apartament(rand_range(1, 400), choice(buildings), choice(owners))
        for _ in range(30)
    ))

def make_service_types():
    class service_type():
        def __init__(self, description, has_counter, price_per_month) -> None:
            self.id = uuid()
            self.description = description
            self.has_counter = has_counter
            self.price_per_month = price_per_month

        def insert_query(self):
            return f"INSERT INTO public.service_types VALUES ('{self.id}', '{self.description}', '{self.has_counter}', '{self.price_per_month}');"

    return [
        service_type("Горячая вода", True, rand_range(1000, 10000)),
        service_type("Холодная вода", True, rand_range(1000, 10000)),
        service_type("Отопление", True, rand_range(1000, 10000)),
        service_type("Вывоз мусора", False, rand_range(1000, 10000)),
        service_type("Уборка общественных помещений", False, rand_range(1000, 10000)),
        service_type("Лифты", False, rand_range(1000, 10000)),
        service_type("Обслуживание кофепоинтов", False, rand_range(1000, 10000)),
        service_type("Поливка растений", False, rand_range(1000, 10000)),
        service_type("Электричество", True, rand_range(1000, 10000)),
        service_type("Холодное отопление", True, rand_range(1000, 10000)),
    ]

def make_payments(service_types, apartaments):
    year_montgh = lambda date: date[:-2] + "01"
    rand_date = lambda: f"{rand_range(2000, 2023)}-{to_calendar(rand_range(1, 13))}-{to_calendar(rand_range(1, 29))}"

    class payment():
        def __init__(self, payment_date, apartament, service_type) -> None:
            self.id = uuid()
            self.payment_date = payment_date
            self.period = year_montgh(payment_date)
            self.apartament_id = apartament.id
            self.service_type_id = service_type.id

        def insert_query(self):
            return f"INSERT INTO public.payments VALUES ('{self.id}', '{self.period}', '{self.payment_date}', '{self.apartament_id}', '{self.service_type_id}');"

    return list(set(
        payment(rand_date(), choice(apartaments), choice(service_types))
        for _ in range(1500)
    ))

owners = make_owners()
buildings = make_buildings()
apartaments = make_apartaments(owners, buildings)
service_types = make_service_types()
payments = make_payments(service_types, apartaments)

with open("lab2.2.fill.sql", "w", encoding="utf-8") as f:
    res = '\n'.join([x.insert_query() for x in owners]) + "\n" + \
        '\n'.join([x.insert_query() for x in buildings]) + "\n" + \
        '\n'.join([x.insert_query() for x in apartaments]) + "\n" + \
        '\n'.join([x.insert_query() for x in service_types]) + "\n" + \
        '\n'.join([x.insert_query() for x in payments]) + "\n"
    # print(res)
    f.write(res)