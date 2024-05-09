#!/bin/bash

    tail -q -n +2 /extracts/data/mgh/omop-omop-person-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-observation-period-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-visit-occurrence-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-visit-detail-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-condition-occurrence-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-drug-exposure-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-procedure-occurrence-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-device-exposure-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-measurement-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-observation-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-death-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-note-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_note from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-note-nlp-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_note_nlp from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-specimen-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_specimen from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-drug-era-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_drug_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-dose-era-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_dose_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/mgh/omop-condition-era-export.csv |     psql -d mgh  -U postgres -p 5432     -c "\copy omopcdm.src_condition_era from stdin csv delimiter e','"