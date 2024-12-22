#!/bin/bash

    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/person.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/observation_period.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/visit_occurrence.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/visit_detail.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/DUKE_TMP/Duke3500/condition_occurrence.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/DUKE_TMP/Duke3500/drug_exposure.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/DUKE_TMP/Duke3500/procedure_occurrence.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/DUKE_TMP/Duke3500/device_exposure.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/DUKE_TMP/Duke3500/measurement.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/DUKE_TMP/Duke3500/observation.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/death.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/note.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_note from stdin csv delimiter e','"


    tail -q -n +3 /extracts/data/DUKE_TMP/Duke3500/note_nlp.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_note_nlp from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/specimen.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_specimen from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/drug_era.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_drug_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/dose_era.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_dose_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/DUKE_TMP/Duke3500/condition_era.csv |     psql -d duke  -U postgres -p 5432     -c "\copy omopcdm.src_condition_era from stdin csv delimiter e','"