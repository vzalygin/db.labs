CREATE TABLE "public.payments" (
	"id" uuid NOT NULL,
	"date" DATE NOT NULL,
	"period" DATE NOT NULL,
	"amount" integer NOT NULL,
	"apartament" uuid NOT NULL,
	"service_type" uuid NOT NULL,
	CONSTRAINT "payments_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.service_types" (
	"id" uuid NOT NULL,
	"description" varchar NOT NULL,
	"has_counter" bool NOT NULL,
	"price_per_month" integer NOT NULL,
	CONSTRAINT "service_types_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.apartaments" (
	"id" uuid NOT NULL,
	"number" integer NOT NULL,
	"building" uuid NOT NULL,
	"owner" uuid NOT NULL,
	CONSTRAINT "apartaments_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.owners" (
	"id" uuid NOT NULL,
	"name" varchar NOT NULL,
	"last_name" varchar NOT NULL,
	CONSTRAINT "owners_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.buildings" (
	"id" uuid NOT NULL,
	"street" varchar NOT NULL,
	"number" integer NOT NULL,
	CONSTRAINT "buildings_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "payments" ADD CONSTRAINT "payments_fk0" FOREIGN KEY ("apartament") REFERENCES "apartaments"("id");
ALTER TABLE "payments" ADD CONSTRAINT "payments_fk1" FOREIGN KEY ("service_type") REFERENCES "service_types"("id");


ALTER TABLE "apartaments" ADD CONSTRAINT "apartaments_fk0" FOREIGN KEY ("building") REFERENCES "buildings"("id");
ALTER TABLE "apartaments" ADD CONSTRAINT "apartaments_fk1" FOREIGN KEY ("owner") REFERENCES "owners"("id");
