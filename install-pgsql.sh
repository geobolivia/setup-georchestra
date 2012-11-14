#!/bin/bash

aptitude install sudo postgresql-8.4-postgis

sudo -u postgres -i psql -c "CREATE USER \"www-data\" CREATEDB PASSWORD 'www-data'"
sudo -u postgres -i psql -c "CREATE DATABASE geonetwork OWNER \"www-data\" TEMPLATE template0 ENCODING 'UTF8'"
sudo -u postgres -i psql -c "CREATE LANGUAGE plpgsql"
sudo -u postgres -i psql -f /usr/share/postgresql/8.4/contrib/postgis-1.5/postgis.sql
sudo -u postgres -i psql -f /usr/share/postgresql/8.4/contrib/postgis-1.5/spatial_ref_sys.sql
sudo -u postgres -i psql -f /usr/share/postgresql/8.4/contrib/postgis_comments.sql

echo "host       geonetwork      www-data    127.0.0.1/32       md5" >> /etc/postgresql/8.4/main/pg_hba.conf
echo "hostssl    geonetwork      www-data    127.0.0.1/32       md5" >> /etc/postgresql/8.4/main/pg_hba.conf

service postgresql reload

