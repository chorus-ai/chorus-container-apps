with measurement_dates as
         (
             SELECT person_id,
                    min(measurement_date) as measurement_least_value,
                    max(measurement_date) as measurement_greatest_value
             FROM omopcdm.measurement
             group by person_id
         ),
     condition_dates as
         (
             SELECT person_id,
                    min(condition_start_date) as condition_least_start_value,
                    max(condition_end_date)   as condition_greatest_end_value,
                    max(condition_start_date) as condition_greatest_start_value
             FROM omopcdm.condition_occurrence
             group by person_id
         ),
     observation_dates as
         (
             SELECT person_id,
                    min(observation_date) as observation_least_value,
                    max(observation_date) as observation_greatest_value
             FROM omopcdm.observation
             group by person_id
         ),
     procedure_dates as
         (
             SELECT person_id,
                    min(procedure_date) as procedure_least_value,
                    max(procedure_date) as procedure_greatest_value
             FROM omopcdm.procedure_occurrence
             group by person_id
         ),
     drug_dates as
         (
             SELECT person_id,
                    min(drug_exposure_start_date) as drug_least_value,
                    max(drug_exposure_end_date)   as drug_greatest_value
             FROM omopcdm.drug_exposure
             group by person_id
         ),
     dev_dates as
         (
             SELECT person_id,
                    min(device_exposure_start_date) as dev_least_value,
                    max(device_exposure_end_date)   as dev_greatest_value
             FROM omopcdm.device_exposure
             group by person_id
         ),
     spec_dates as
         (
             SELECT person_id,
                    min(specimen_date) as spec_least_value,
                    max(specimen_date) as spec_greatest_value
             FROM omopcdm.specimen
             group by person_id
         ),
     death_dates as
         (
             SELECT person_id,
                    min(death_date) as death_least_value,
                    max(death_date) as death_greatest_value
             FROM omopcdm.death
             group by person_id
         ),
     least_mes_date as
         (SELECT distinct s1.person_id,
                          LEAST(m.measurement_least_value, co.condition_least_start_value, o.observation_least_value,
                                po.procedure_least_value, dr.drug_least_value, de.dev_least_value, sp.spec_least_value,
                                d.death_least_value)       as least_value,
                          GREATEST(m.measurement_greatest_value, co.condition_greatest_start_value,
                                   co.condition_greatest_end_value,
                                   o.observation_greatest_value, po.procedure_greatest_value, dr.drug_greatest_value,
                                   de.dev_greatest_value, sp.spec_greatest_value,
                                   d.death_greatest_value) as greatest_value
          FROM omopcdm.person s1
                   LEFT JOIN observation_dates o ON o.person_id = s1.person_id
                   LEFT JOIN condition_dates co ON co.person_id = s1.person_id
                   LEFT JOIN measurement_dates m ON m.person_id = s1.person_id
                   LEFT JOIN procedure_dates po ON po.person_id = s1.person_id
                   LEFT JOIN drug_dates dr ON dr.person_id = s1.person_id
                   LEFT JOIN dev_dates de ON de.person_id = s1.person_id
                   LEFT JOIN spec_dates sp ON sp.person_id = s1.person_id
                   LEFT JOIN death_dates d ON d.person_id = s1.person_id)
INSERT
INTO omopcdm.observation_period (observation_period_id, person_id, observation_period_start_date, observation_period_end_date,
                                      period_type_concept_id)
SELECT row_number() over (),
       p.person_id,
       MIN(ld.least_value)    as observation_period_start_date,
       MAX(ld.greatest_value) as observation_period_end_date,
       32880                  as period_type_concept_idexit
FROM omopcdm.person p
         inner join least_mes_date ld on ld.person_id = p.person_id
WHERE ld.least_value IS NOT NULL AND ld.greatest_value IS NOT NULL
GROUP BY p.person_id;

CREATE INDEX idx_observation_period_id_1 ON omopcdm.observation_period (person_id ASC);
CLUSTER omopcdm.observation_period USING idx_observation_period_id_1;

ALTER TABLE omopcdm.OBSERVATION_PERIOD
    ADD CONSTRAINT xpk_OBSERVATION_PERIOD PRIMARY KEY (observation_period_id);