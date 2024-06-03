#!/bin/bash

cohortids=$(curl "${CHORUS_WEBAPI_BACKEND}cohortdefinition" | jq -r '.[].id')


for id in $cohortids; do
    curl "${CHORUS_WEBAPI_BACKEND}cohortdefinition/$id/generate/MERGE" >> /tmp/cohortgen.log
    sleep 10
    echo "------" >> /tmp/cohortgen.log
done
