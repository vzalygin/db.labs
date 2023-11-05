CREATE TABLE IF NOT EXISTS public.buildings (
    id uuid PRIMARY KEY,
    street varchar NOT NULL,
    number integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public.owners (
    id uuid PRIMARY KEY,
    name varchar NOT NULL,
    last_name varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS public.apartaments (
    id uuid PRIMARY KEY,
    number integer NOT NULL,
    full_address jsonb NOT NULL,
    building_id uuid NOT NULL REFERENCES buildings ON DELETE CASCADE, 
    owner_id uuid  NOT NULL REFERENCES owners ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS public.service_types (
    id uuid PRIMARY KEY,
    description varchar NOT NULL,
    has_counter bool NOT NULL,
    price_per_month integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public.payments (
    id uuid PRIMARY KEY,
    period date NOT NULL,
    payment_date date NOT NULL,
    price integer NOT NULL,
    service_type_id uuid[] NOT NULL,
    apartament_id uuid NOT NULL REFERENCES apartaments ON DELETE CASCADE
);