#!/bin/bash

cohortids=$(curl -s "${CHORUS_WEBAPI_BACKEND}cohortdefinition" | jq -r '.[].id')
psql -d merge -c "ALTER ROLE postgres SET statement_timeout = '60s';" > /dev/null
for id in $cohortids; do
  rm -rf mssql.sql
  rm -rf tmp.sql
  echo "DROP SCHEMA IF EXISTS tmp_cohorts CASCADE; CREATE SCHEMA tmp_cohorts; SET search_path=tmp_cohorts;" > mssql.sql
  echo "Fetching SQL for cohort $id..."
  echo "{\"options\": {\"vocabularySchema\":\"omopcdm\", \"resultSchema\":\"omopcdm\", \
    \"targetTable\":\"cohort\", \"cdmSchema\":\"omopcdm\", \"cohortId\":$id}, \"expression\": \
    $(curl -s "${CHORUS_WEBAPI_BACKEND}cohortdefinition/${id}" | jq -r '.|.expression')}" | \
    curl -s --header "Content-Type: application/json" \
    --request POST \
    --data @- \
    "${CHORUS_WEBAPI_BACKEND}cohortdefinition/sql" | jq -r '.|.templateSql' | sed 's:--.*$::g' | tr -d '\r' | tr '\n' ' ' >> mssql.sql
  FIXED=$(cat mssql.sql| tr '\n' ' ' | tr -d '\"' | tr '\t' ' ')
  echo "{\"targetdialect\": \"postgresql\", \"SQL\": \"$FIXED\", \"parameters\": {}}" | \
    curl -s --header "Content-Type: application/json" \
    --request POST \
    --data @- \
    "${CHORUS_WEBAPI_BACKEND}sqlrender/translate" | jq -r '.|.targetSQL' | sed 's/ cohort / omopcdm.cohort /g' >> tmp.sql
  psql -d merge -f tmp.sql -v ON_ERROR_STOP=1  > /dev/null
  echo "Cohort ${id} generated!"
done
psql -d merge -c "ALTER ROLE postgres SET statement_timeout = '0';"  > /dev/null
