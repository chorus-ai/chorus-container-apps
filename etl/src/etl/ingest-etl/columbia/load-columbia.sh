#!/bin/bash

    tail -q -n +2 /extracts/data/COL_TMP/OMOP/PERSON.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/OBSERVATION_PERIOD.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/VISIT_OCCURRENCE.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/VISIT_DETAIL.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/CONDITION_OCCURRENCE.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/DRUG_EXPOSURE.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/PROCEDURE_OCCURRENCE.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/DEVICE_EXPOSURE.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/MEASUREMENT.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/OBSERVATION.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/DEATH.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/DRUG_ERA.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_drug_era from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/COL_TMP/OMOP/CONDITION_ERA.csv |     psql -d columbia  -U postgres -p 5432     -c "\copy omopcdm.src_condition_era from stdin csv delimiter e','"