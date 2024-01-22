#!/bin/sh

set -e

if [ ! -e /root/.ssh/id_rsa ]; then
    if [ -n "$ID_RSA" ]; then
        printf "%s\n" "$ID_RSA" > /root/.ssh/id_rsa
        chmod go-rwx /root/.ssh/id_rsa
    fi
fi

set -x

cd /run/etl

prefect config view
prefect deployment build --name ingest-etl --tag etl --work-queue etl --limit 1 --skip-upload --apply etl:ingest_etl
prefect deployment build --name merge-etl --tag etl --work-queue etl --limit 1 --skip-upload --apply etl:merge_etl
prefect deployment build --name index-network --tag etl --work-queue etl --limit 1 --skip-upload --apply etl:index_network
prefect deployment build --name upload-vocabulary --tag etl --work-queue etl --limit 1 --skip-upload --apply etl:upload_vocabulary
exec prefect agent start --work-queue etl ${RUN_ONCE:+--run-once}
