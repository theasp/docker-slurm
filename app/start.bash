#!/bin/bash

set -xeo pipefail

export HOSTNAME=$(hostname)
export CLUSTERNAME=$(hostname)


mkdir -p /var/run/munge
mkdir -p /var/log/supervisor
mkdir -p /var/log/slurm-llnl
mkdir -p /var/run/slurm-llnl
chown munge:munge /var/run/munge/

test -e /etc/munge/munge.key || /sbin/create-munge-key
test -e /etc/slurm-llnl/slurm.conf || envsubst < /app/slurm.conf.envsubst > /etc/slurm-llnl/slurm.conf

/usr/bin/supervisord --nodaemon --configuration /app/supervisord.conf
