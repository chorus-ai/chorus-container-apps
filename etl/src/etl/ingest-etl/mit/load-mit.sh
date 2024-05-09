#!/bin/bash

    tail -q -n +2 /extracts/data/download/person.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/observation-period.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/visit-occurrence.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/visit_detail.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/condition-occurrence.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/drug-exposure.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/procedure-occurrence.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/device-exposure.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/measurement.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/observation.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/death.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/note.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_note from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/note-nlp.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_note_nlp from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/specimen.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_specimen from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/drug-era.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_drug_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/dose_era.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_dose_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/download/condition_era.csv |     psql -d mit  -U postgres -p 5432     -c "\copy omopcdm.src_condition_era from stdin csv delimiter e','"