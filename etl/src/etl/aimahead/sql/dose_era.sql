INSERT INTO
    aimahead_60.dose_era (
                             dose_era_id,
                             person_id,
                             drug_concept_id,
                             unit_concept_id,
                             dose_value,
                             dose_era_start_date,
                             dose_era_end_date
                         )
SELECT dose_era_id,
       person_id,
       drug_concept_id,
       unit_concept_id,
       dose_value,
       dose_era_start_date,
       dose_era_end_date
FROM aimahead.dose_era
WHERE person_id IN (
                       SELECT person_id
                       FROM aimahead_60.person
                   )
  AND drug_concept_id NOT IN
      (
          SELECT concept_id
          FROM persist.censored_concept
      );