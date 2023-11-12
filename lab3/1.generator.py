#!/bin/python3

import random

APARTAMENTS_COUNT = 1_000_000
PAYMENTS_COUNT = 5_000_000

def uuid():
    import uuid
    return str(uuid.uuid4())

choice = random.choice
sample = random.sample
rand_range = random.randrange
to_calendar = lambda x: str(100+x)[1:]

def make_owners():
    class owner():
        def __init__(self, name, last_name):
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
        def __init__(self, number, building, owner):
            self.id = uuid()
            self.number = number
            self.building = building
            self.owner = owner

        def insert_query(self):
            jsonb = "{ \"street\": \"" + str(self.building.street) + "\", \"house_number\": \"" + str(self.building.number) + "\", \"apartament_number\": \"" + str(self.number) + "\" }"
            return f"INSERT INTO public.apartaments VALUES ('{self.id}', '{self.number}', '{jsonb}', '{self.building.id}', '{self.owner.id}');"

    a = []
    for i in range(APARTAMENTS_COUNT):
        if (i % 100_000 == 0):
            print(i)
        a.append(apartament(rand_range(1, 1_000), choice(buildings), choice(owners)))
    return a

def make_service_types():
    class service_type():
        def __init__(self, description, has_counter, price_per_month):
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
        def __init__(self, payment_date, apartament, services):
            self.id = uuid()
            self.payment_date = payment_date
            self.period = year_montgh(payment_date)
            self.apartament_id = apartament.id
            self.services = services

        def insert_query(self):
            price = sum(x.price_per_month for x in self.services)
            uuids = "{" + ', '.join(x.id for x in self.services) +  "}"
            return f"INSERT INTO public.payments VALUES ('{self.id}', '{self.period}', '{self.payment_date}', '{price}', '{uuids}'::uuid[], '{self.apartament_id}');"
    a = []
    for i in range(PAYMENTS_COUNT):
        if (i % 100_000 == 0):
            print(i)
        a.append(payment(rand_date(), choice(apartaments), sample(service_types, rand_range(1, 11))))

    return a

def apply_progress(arr, name):
    print(f'generated {len(arr)} rows for {name};')
    return arr

owners = apply_progress(make_owners(), "owners")
buildings = apply_progress(make_buildings(), "buildings")
apartaments = apply_progress(make_apartaments(owners, buildings), "apartaments")
service_types = apply_progress(make_service_types(), "service_types")
payments = apply_progress(make_payments(service_types, apartaments), "payments")

with open("lab3.1.fill.sql", "w", encoding="utf-8") as f:
    for xx in [owners, buildings, service_types, apartaments, payments]:
        print(f"prepare {len(xx)} inserts")
        for i, x in enumerate(xx):
            if(i % 100_000 == 0):
                print(i)
            f.write(x.insert_query()+"\n")