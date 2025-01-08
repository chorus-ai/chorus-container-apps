#!/bin/bash

    tail -q -n +2 /extracts/data/EMORY_TMP/omop/person.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_person from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/observation_period.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/visit_occurrence.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/visit_detail.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/condition_occurrence.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/drug_exposure.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/procedure_occurrence.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/device_exposure.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/measurement.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_measurement from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/observation.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_observation from stdin csv delimiter e','"


    tail -q -n +2 /extracts/data/EMORY_TMP/omop/death.csv |     psql -d emory  -U postgres -p 5432     -c "\copy omopcdm.src_death from stdin csv delimiter e','"