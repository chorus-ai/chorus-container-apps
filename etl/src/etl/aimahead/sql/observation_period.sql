INSERT INTO aimahead_60.observation_period (
  observation_period_id,
  person_id,
  observation_period_start_date,
  observation_period_end_date,
  period_type_concept_id
)
SELECT observation_period_id,
  person_id,
  observation_period_start_date,
  observation_period_end_date,
  period_type_concept_id
FROM aimahead.observation_period
WHERE person_id IN (SELECT person_id FROM aimahead_60.person);
