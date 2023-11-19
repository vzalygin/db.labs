#!/bin/sh

USER=vzalygin
PASSWORD=12345678
DB_NAME=postgres

psql -h localhost -p 5432 -d $DB_NAME -U $USER -a -f $1