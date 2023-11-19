#!/bin/sh

DATA_PATH="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")data-demo/"
USER=vzalygin
PASSWORD=12345678
DB_NAME=demo
INIT=./lab1/demo-small-20170815.sql

docker run \
    --name postgres-demo -p 5433:5432 \
    -e POSTGRES_USER=$USER \
    -e POSTGRES_PASSWORD=$PASSWORD \
    -e POSTGRES_DB=$DB_NAME \
    -e PGDATA=/var/lib/pgsql/data/pgdata \
    -d postgres:16-alpine

sleep 5 

psql -h localhost -p 5433 -d $DB_NAME -U $USER -a -f $INIT