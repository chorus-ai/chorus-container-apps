INSERT INTO
    aimahead_60.condition_era (
                                   condition_era_id,
                                   person_id,
                                   condition_concept_id,
                                   condition_era_start_date,
                                   condition_era_end_date,
                                   condition_occurrence_count
                               )
SELECT condition_era_id,
       person_id,
       condition_concept_id,
       condition_era_start_date,
       condition_era_end_date,
       condition_occurrence_count
FROM aimahead.condition_era
WHERE person_id IN (
                       SELECT person_id
                       FROM aimahead_60.person
                   )
AND condition_concept_id NOT IN
                   (
                       SELECT concept_id FROM persist.censored_concept
                       );