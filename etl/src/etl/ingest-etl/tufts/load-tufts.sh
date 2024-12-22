#!/bin/bash

    tail -q -n +2 /extracts/data/TUFTS_TMP/person.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/observation_period.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/visit_occurrence.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/visit_detail.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/TUFTS_TMP/condition_occurrence.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/TUFTS_TMP/drug_exposure.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/TUFTS_TMP/procedure_occurrence.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/TUFTS_TMP/device_exposure.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/TUFTS_TMP/measurement.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/TUFTS_TMP/observation.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/death.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/note.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_note from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/TUFTS_TMP/note_nlp.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_note_nlp from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/specimen.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_specimen from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/drug_era.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_drug_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/dose_era.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_dose_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/TUFTS_TMP/condition_era.csv |     psql -d tufts  -U postgres -p 5432     -c "\copy omopcdm.src_condition_era from stdin csv delimiter e','"