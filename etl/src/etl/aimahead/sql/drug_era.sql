INSERT INTO
    aimahead_60.drug_era (
                             drug_era_id,
                             person_id,
                             drug_concept_id,
                             drug_era_start_date,
                             drug_era_end_date,
                             drug_exposure_count,
                             gap_days
                         )
SELECT drug_era_id,
       person_id,
       drug_concept_id,
       drug_era_start_date,
       drug_era_end_date,
       drug_exposure_count,
       gap_days
FROM aimahead.drug_era
WHERE person_id IN (
                       SELECT person_id
                       FROM aimahead_60.person
                   )
  AND drug_concept_id NOT IN
      (
          SELECT concept_id
          FROM persist.censored_concept
      );