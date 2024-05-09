#!/bin/bash

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/PERSON.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.person FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/OBSERVATION_PERIOD.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.observation_period FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/VISIT_OCCURRENCE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.visit_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/VISIT_DETAIL.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.visit_detail FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/CONDITION_OCCURRENCE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.condition_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/DRUG_EXPOSURE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.drug_exposure FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/PROCEDURE_OCCURRENCE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.procedure_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/DEVICE_EXPOSURE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.device_exposure FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/MEASUREMENT.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.measurement FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/OBSERVATION.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.observation FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/DEATH.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.death FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/NOTE.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.note FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/NOTE_NLP.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.note_nlp FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/SPECIMEN.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.specimen FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/DRUG_ERA.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.drug_era FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/DOSE_ERA.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.dose_era FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/seattle/*/OMOP_tables/CONDITION_ERA.csv |     psql -d seattle  -U postgres -p 5432     -c "\copy omopcdm.condition_era FROM STDIN CSV DELIMITER E','"