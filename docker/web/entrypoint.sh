#!/bin/sh
set -eux

holdup tcp://$DATABASE_HOST:5432

# we could do migrations here, eg:
# django-admin migrate --noinput

exec supervisord --nodaemon --configuration=/etc/supervisor/supervisord.conf --logfile=/dev/stdout --logfile_maxbytes=0
