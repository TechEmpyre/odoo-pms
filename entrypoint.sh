#!/bin/bash

set -e

until pg_isready -h $HOST -U $USER
do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

exec python3 /opt/odoo/odoo-bin \
    -c /etc/odoo/odoo.conf
