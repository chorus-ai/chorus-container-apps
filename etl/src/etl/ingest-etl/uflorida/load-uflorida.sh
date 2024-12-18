#!/bin/bash

    tail -q -n +2 /extracts/data/UF_TMP/OMOP/person.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/observation_period.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/visit_occurrence.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/visit_detail.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/condition_occurrence.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/drug_exposure.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/procedure_occurrence.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/device_exposure.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/measurement.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/observation.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/death.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/note.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_note from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UF_TMP/OMOP/note_nlp.csv |     psql -d florida  -U postgres -p 5432     -c "\copy omopcdm.src_note_nlp from stdin csv delimiter e','"