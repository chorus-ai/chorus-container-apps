#!/bin/bash

psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.person to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.person from stdin csv " 


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.observation_period to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.observation_period from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.visit_occurrence to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.visit_occurrence from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.visit_detail to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.visit_detail from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.condition_occurrence to stdout csv " |  psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.condition_occurrence from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.drug_exposure to stdout csv "| psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.drug_exposure from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.procedure_occurrence to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.procedure_occurrence from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.device_exposure to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.device_exposure from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.measurement to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.measurement from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.observation to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.observation from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.death to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.death from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.note to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.note from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.note_nlp to stdout csv "| psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.note_nlp from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.specimen to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.specimen from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.drug_era to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.drug_era from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.dose_era to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.dose_era from stdin csv "


psql "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/merge"    -c "\copy aimahead_60.condition_era to stdout csv " | psql -d aimahead  -U postgres -p 5432     -c "\copy omopcdm.condition_era from stdin csv "

# VOCABULARY TABLES

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.concept TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.concept FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.concept_relationship TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.concept_relationship FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.concept_ancestor TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.concept_ancestor FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.concept_class TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.concept_class FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.concept_recommended TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.concept_recommended FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.concept_synonym TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.concept_synonym FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.concept_hierarchy TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.concept_hierarchy FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.domain TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.domain FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.drug_strength TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.drug_strength FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.relationship TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.relationship FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.source_to_concept_map TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.source_to_concept_map FROM STDIN CSV"

psql  "postgresql://postgres:$1@psql-mgh-jhamill-chorus-troubleshooting-test.postgres.database.azure.com/tufts"  -c "\copy vocabulary.vocabulary TO STDOUT CSV" | psql -d aimahead -c "\copy vocabulary.vocabulary FROM STDIN CSV"
