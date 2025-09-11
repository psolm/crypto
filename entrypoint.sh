#!/bin/bash
python Exchange/manage.py migrate --noinput

exec "$@"
