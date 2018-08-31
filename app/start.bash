#!/bin/bash

set -xeo pipefail

export HOSTNAME=$(hostname)
export CLUSTERNAME=$(hostname)

test -e /etc/munge/munge.key || /sbin/create-munge-key

mkdir -p /var/run/munge
chown munge:munge /var/run/munge/

envsubst < /app/slurm.conf.envsubst > /etc/slurm-llnl/slurm.conf
/usr/bin/supervisord --nodaemon --configuration /app/supervisord.conf
