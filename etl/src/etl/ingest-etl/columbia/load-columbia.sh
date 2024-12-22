#!/bin/bash

    tail -q -n +2 /extracts/data/COL_TMP/person.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/observation_period.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/visit_occurrence.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/visit_detail.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/COL_TMP/condition_occurrence.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/COL_TMP/drug_exposure.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/COL_TMP/procedure_occurrence.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/COL_TMP/device_exposure.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/COL_TMP/measurement.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/COL_TMP/observation.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/death.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/note.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_note from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/COL_TMP/note_nlp.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_note_nlp from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/specimen.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_specimen from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/drug_era.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_drug_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/dose_era.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_dose_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/condition_era.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_condition_era from stdin csv delimiter e','"