WITH
    observation_period_all AS (
        SELECT
            person_id,
            MIN(condition_start_date)                              AS min_date,
            MAX(IFNULL (condition_end_date, condition_start_date)) AS max_date
        FROM
            condition_occurrence
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(drug_exposure_start_date),
            MAX(IFNULL (drug_exposure_end_date,drug_exposure_start_date))
        FROM
            drug_exposure
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(procedure_date),
            MAX(IFNULL (procedure_end_date,procedure_date))
        FROM
            procedure_occurrence
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(observation_date),
            MAX(observation_date)
        FROM
            observation
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(measurement_date),
            MAX(measurement_date)
        FROM
            measurement
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(device_exposure_start_date),
            MAX(IFNULL (device_exposure_end_date,device_exposure_start_date))
        FROM
            device_exposure
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(visit_start_date),
            MAX(IFNULL (visit_end_date,visit_start_date))
        FROM
            visit_occurrence
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(visit_detail_start_date),
            MAX(IFNULL (visit_detail_end_date,visit_detail_start_date))
        FROM
            visit_detail
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(specimen_date),
            MAX(specimen_date)
        FROM
            specimen
        GROUP BY
            person_id
        UNION
        SELECT
            person_id,
            MIN(death_date),
            MAX(death_date)
        FROM
            death
        GROUP BY
            person_id
    )
INSERT INTO
    observation_period
SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            observation_period_all.person_id
    ) AS observation_period_id,
    CAST(observation_period_all.person_id AS INTEGER) AS person_id,
    CAST(MIN(min_date) AS DATE) AS observation_period_start_date,
    CAST(MAX(max_date) AS DATE) AS observation_period_end_date,
    CAST(44814724 AS INTEGER) AS period_type_concept_id
FROM
    observation_period_all
    INNER JOIN person ON observation_period_all.person_id = person.person_id
GROUP BY
    observation_period_all.person_id;