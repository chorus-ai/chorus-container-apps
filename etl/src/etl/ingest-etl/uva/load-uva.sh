#!/bin/bash

    tail -q -n +2 /extracts/data/UVA_TMP/PERSON.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/OBSERVATION_PERIOD.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/VISIT_OCCURRENCE.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/VISIT_DETAIL.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/CONDITION_OCCURRENCE.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/DRUG_EXPOSURE.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/PROCEDURE_OCCURRENCE.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/DEVICE_EXPOSURE.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/MEASUREMENT.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/OBSERVATION.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/UVA_TMP/DEATH.csv |     psql -d virginia  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"