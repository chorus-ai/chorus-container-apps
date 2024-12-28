#!/bin/bash

psql -d ohdsi -U postgres -p 5432 -c "\copy public.all_metadata_sample TO '/pilot_meta/data/sample.csv' CSV HEADER"

psql -d ohdsi -U postgres -p 5432 -c "\copy public.by_site_metadata TO '/pilot_meta/data/by_site.csv' CSV HEADER"
