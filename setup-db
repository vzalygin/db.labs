#!/bin/sh

DATA_PATH="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")data/"
USER=vzalygin
PASSWORD=12345678
DB_NAME=demo
INIT=demo-small-20170815.sql

docker run \
    --name postgres-stand -p 5432:5432 \
    -e POSTGRES_USER=$USER \
    -e POSTGRES_PASSWORD=$PASSWORD \
    -e POSTGRES_DB=$DB_NAME \
    -e PGDATA=/var/lib/pgsql/data/pgdata \
    --mount type=bind,source="$DATA_PATH",target=/var/lib/pgsql/data \
    -d postgres:16-alpine

sleep 5 

psql -h localhost -d $DB_NAME -U $USER -a -f $INIT