#!/bin/bash

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/PERSON.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_person FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/OBSERVATION_PERIOD.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_observation_period FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/VISIT_OCCURRENCE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_visit_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/VISIT_DETAIL.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_visit_detail FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/CONDITION_OCCURRENCE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_condition_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/DRUG_EXPOSURE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_drug_exposure FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/PROCEDURE_OCCURRENCE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_procedure_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/DEVICE_EXPOSURE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_device_exposure FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/MEASUREMENT.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_measurement FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/OBSERVATION.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_observation FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/DEATH.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_death FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/NOTE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_note FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/NOTE_NLP.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_note_nlp FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/SPECIMEN.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_specimen FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/DRUG_ERA.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_drug_era FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/DOSE_ERA.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_dose_era FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/SEATTLE_TMP/OMOP/CONDITION_ERA.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.src_condition_era FROM STDIN CSV DELIMITER E','"