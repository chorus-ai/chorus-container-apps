#!/bin/bash

# Create Tables

psql -d ohdsi -U postgres -p 5432 -f "/app/get_allfiles_grouped.sql"

psql -d merge -U postgres -p 5432 -f "/app/get_condition_summary.sql"

psql -d merge -U postgres -p 5432 -f "/app/get_demo_dash.sql"

# ------------------------------

# Loop over databases to get person and note counts

echo "site, count_person, count_note" > "/app/data/omop_counts.csv"

declare -a arr=("columbia" "duke" "emory" "mgh" "mit" "mayo" "nationwide" "ucla" "ucsf" "florida" "pittsburgh" "seattle" "virginia" "tufts")

for site in "${arr[@]}"
do
   count_person=$(psql -qtAX -d "$site" -c "SELECT count(*) FROM omopcdm.person;")
   count_note=$(psql -qtAX -d "$site" -c "SELECT count(distinct(person_id)) FROM omopcdm.note;")
   echo "$site, $count_person, $count_note" >> "/app/data/omop_counts.csv"
done

# ------------------------------

# Export Tables

psql -d ohdsi -U postgres -p 5432 -c "\copy public.allfiles_grouped TO '/app/data/allfiles_grouped.csv' CSV HEADER"

psql -d merge -U postgres -p 5432 -c "\copy public.demo_dash TO '/app/data/demograph.csv' CSV HEADER"

psql -d merge  -U postgres -p 5432 -c "\copy persist.source_key TO '/app/data/source_key.csv' CSV HEADER"

psql -d merge  -U postgres -p 5432 -c "\copy public.domain_summary_condition TO '/app/data/chorus-conditions.csv' CSV HEADER"

# ------------------------------