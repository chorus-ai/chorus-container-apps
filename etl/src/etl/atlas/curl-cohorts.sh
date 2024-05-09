#!/bin/bash


for filename in /tmp/cohorts/queries/*.json; do
  cat $filename | curl "${CHORUS_WEBAPI_BACKEND}cohortdefinition" --data-binary @- -H "Content-Type: application/json"
  sleep 3
done
