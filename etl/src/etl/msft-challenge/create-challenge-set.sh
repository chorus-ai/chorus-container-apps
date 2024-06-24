#!/bin/bash

# Note - partially created using the `pipe_table_transfer` function in common.py
# Modified to allow for site-specific filtering on the tables transferred

src_list="'mgh', 'mit', 'nationwide', 'pittsburgh', 'seattle'"
trg_schema="msft_challenge"

psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.person WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.person FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.observation_period WHERE person_id IN (SELECT person_id FROM omopcdm.person WHERE src_name IN ($src_list))) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.observation_period FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.visit_occurrence WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.visit_occurrence FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.visit_detail WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.visit_detail FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.condition_occurrence WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.condition_occurrence FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.drug_exposure WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.drug_exposure FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.procedure_occurrence WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.procedure_occurrence FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.device_exposure WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.device_exposure FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.measurement WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.measurement FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.observation WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.observation FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.death WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.death FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.note WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.note FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.note_nlp WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.note_nlp FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.specimen WHERE src_name IN ($src_list)) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.specimen FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.drug_era WHERE person_id IN (SELECT person_id FROM omopcdm.person WHERE src_name IN ($src_list))) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.drug_era FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.dose_era WHERE person_id IN (SELECT person_id FROM omopcdm.person WHERE src_name IN ($src_list))) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.dose_era FROM STDIN CSV"


psql -d merge -U postgres -c "\copy (SELECT * FROM omopcdm.condition_era WHERE person_id IN (SELECT person_id FROM omopcdm.person WHERE src_name IN ($src_list))) TO STDOUT CSV" | psql -d challenge -U postgres -c "\copy $trg_schema.condition_era FROM STDIN CSV"