#!/bin/bash

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*person*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.person FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*observation_period*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.observation_period FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*visit_occurrence*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.visit_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*visit_detail*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.visit_detail FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*condition_occurrence*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.condition_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*drug_exposure*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.drug_exposure FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*procedure_occurrence*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.procedure_occurrence FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*device_exposure*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.device_exposure FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*measurement*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.measurement FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*observation*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.observation FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*death*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.death FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*note*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.note FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*note_nlp*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.note_nlp FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*specimen*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.specimen FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*drug_era*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.drug_era FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*dose_era*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.dose_era FROM STDIN CSV DELIMITER E','"
    

    tail -q -n +2 /extracts/data/nationwide/*/OMOP/*condition_era*.csv |     psql -d nationwide  -U postgres -p 5432     -c "\copy omopcdm.condition_era FROM STDIN CSV DELIMITER E','"