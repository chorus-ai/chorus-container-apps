INSERT INTO
    omopcdm.condition_occurrence
SELECT
    co.condition_occurrence_id::float::bigint,
    co.person_id::float::bigint,
    COALESCE(co.condition_concept_id::float::bigint, 0),
    co.condition_start_date::date + INTERVAL '1 day'*ds.days AS condition_start_date,
    co.condition_start_date::timestamp + INTERVAL '1 day'*ds.days AS condition_start_datetime,
    NULL AS condition_end_date,
    NULL AS condition_end_datetime,
    co.condition_type_concept_id::float::bigint,
    NULL AS condition_status_concept_id,
    NULL AS stop_reason,
    NULL AS provider_id,
    NULL AS visit_occurrence_id,
    NULL AS visit_detail_id,
    condition_source_value AS condition_source_value,
    NULL AS condition_source_concept_id,
    condition_source_name AS condition_status_source_value
FROM
    omopcdm.src_condition_occurrence AS co
    JOIN persist.date_shift AS ds ON co.person_id::float::bigint = ds.person_id
WHERE condition_start_date IS NOT NULL;


INSERT INTO
    omopcdm.death
SELECT
    d.person_id::float::bigint,
    d.death_date::date + INTERVAL '1 day'*ds.days AS death_date,
    d.death_date::timestamp + INTERVAL '1 day'*ds.days AS death_datetime,
    32817 AS death_type_concept_id,
    NULL AS cause_concept_id,
    NULL AS cause_source_value,
    NULL AS cause_source_concept_id
FROM
    omopcdm.src_death AS d
    JOIN persist.date_shift AS ds ON d.person_id::float::bigint = ds.person_id
WHERE d.death_date IS NOT NULL;

INSERT INTO
    omopcdm.drug_exposure
SELECT
    de.drug_exposure_id::float::bigint,
    de.person_id::float::bigint,
    COALESCE(de.drug_concept_id::float::bigint, 0),
    de.drug_exposure_start_date::date + INTERVAL'1 day'*ds.days  AS drug_exposure_start_date,
    de.drug_exposure_start_date::timestamp + INTERVAL'1 day'*ds.days  AS drug_exposure_start_datetime,
    COALESCE(de.drug_exposure_end_date::date,de.drug_exposure_start_date::date) + INTERVAL'1 day'*ds.days  AS drug_exposure_end_date,
    de.drug_exposure_end_date::timestamp + INTERVAL'1 day'*ds.days AS drug_exposure_end_datetime,
    NULL AS verbatim_end_date,
    drug_type_concept_id::integer AS drug_type_concept_id,
    NULL AS stop_reason,
    NULL AS refills,
    NULL AS quantity,
    NULL AS days_supply,
    NULL AS sig,
    NULL AS route_concept_id,
    NULL AS lot_number,
    NULL AS provider_id,
    NULL AS visit_occurrence_id,
    NULL AS visit_detail_id,
    NULL AS drug_source_value,
    NULL AS drug_source_concept_id,
    NULL AS route_source_value,
    NULL AS dose_unit_source_value
FROM
    omopcdm.src_drug_exposure AS de
    JOIN persist.date_shift AS ds ON de.person_id::float::bigint = ds.person_id
WHERE drug_exposure_start_date IS NOT NULL;


INSERT INTO
    omopcdm.measurement
SELECT
    m.measurement_id::float::bigint,
    m.person_id::float::bigint,
    COALESCE(m.measurement_concept_id::float::bigint, 0),
    m.measurement_date::date + INTERVAL'1 day'*ds.days  AS measurement_date,
    NULLIF(m.measurement_date, 'NULL')::timestamp + INTERVAL'1 day'*ds.days  AS measurement_datetime,
    NULL AS measurement_time,
    m.measurement_type_concept_id::float::bigint,
    NULL AS operator_concept_id,
    NULL AS value_as_number,
    NULL AS value_as_concept_id,
    NULL AS unit_concept_id,
    NULL AS range_low,
    NULL AS range_high,
    NULL AS provider_id,
    NULL AS visit_occurrence_id,
    NULL AS visit_detail_id,
    measurement_source_value,
    NULL AS measurement_source_concept_id,
    unit_source_value,
    NULL AS unit_source_concept_id,
    measurement_source_numeric_value AS value_source_value,
    NULL AS measurement_event_id,
    NULL AS meas_event_field_concept_id
FROM
    omopcdm.src_measurement AS m
    JOIN persist.date_shift AS ds ON m.person_id::float::bigint = ds.person_id
WHERE measurement_date IS NOT NULL;


WITH
    person_shifted AS (
        SELECT
            p.person_id::float::bigint,
            p.gender_concept_id::float::bigint,
            NULLIF(p.birth_datetime, 'NULL')::timestamp + INTERVAL'1 day'*ds.days AS birth_datetime,
            NULLIF(p.race_concept_id, 'NULL')::float::bigint race_concept_id,
            NULLIF(p.ethnicity_concept_id, 'NULL')::float::bigint ethnicity_concept_id,
            NULL::integer AS location_id,
            NULL::integer AS provider_id,
            NULL::integer AS care_site_id,
            NULL::integer AS gender_source_concept_id,
            NULL::integer AS race_source_concept_id,
            NULL::integer AS ethnicity_source_concept_id,
            NULL AS person_source_value,
            p.gender_source_value,
            p.race_source_value,
            p.ethnicity_source_value
        FROM omopcdm.src_person AS p
        JOIN persist.date_shift AS ds ON p.person_id::float::bigint = ds.person_id
    )
INSERT INTO
    omopcdm.person
SELECT
    person_id,
    gender_concept_id,
    date_part('year', birth_datetime) AS year_of_birth,
    date_part('month', birth_datetime) AS month_of_birth,
    date_part('day', birth_datetime) AS day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    location_id,
    provider_id,
    care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id
FROM
    person_shifted;

INSERT INTO
    omopcdm.procedure_occurrence
SELECT
    po.procedure_occurrence_id::float::bigint,
    po.person_id::float::bigint,
    COALESCE(po.procedure_concept_id::float::bigint,0),
    po.procedure_start_date::date + INTERVAL'1 day'*ds.days AS procedure_date,
    po.procedure_start_date::timestamp + INTERVAL'1 day'*ds.days AS procedure_datetime,
    NULL AS procedure_end_date,
    NULL AS procedure_end_datetime,
    po.procedure_type_concept_id::float::bigint,
    NULL AS modifier_concept_id,
    NULL AS quantity,
    NULL AS provider_id,
    NULL AS visit_occurrence_id,
    NULL AS visit_detail_id,
    po.procedure_source_name AS procedure_source_value,
    NULL AS procedure_source_concept_id,
    NULL AS modifier_source_value
FROM
    omopcdm.src_procedure_occurrence AS po
    JOIN persist.date_shift AS ds ON po.person_id::float::bigint = ds.person_id
WHERE procedure_start_date IS NOT NULL;


INSERT INTO
    omopcdm.visit_detail
SELECT
    vd.visit_detail_id::float::bigint,
    vd.person_id::float::bigint,
    vd.visit_concept_id::float::bigint,
    vd.visit_start_date::date + INTERVAL'1 day'*ds.days AS visit_detail_start_date,
    vd.visit_start_date::timestamp + INTERVAL'1 day'*ds.days AS visit_detail_start_datetime,
    vd.visit_end_date::date + INTERVAL'1 day'*ds.days AS visit_detail_end_date,
    vd.visit_end_date::timestamp + INTERVAL'1 day'*ds.days AS visit_detail_end_datetime,
    NULLIF(vd.visit_type_concept_id, 'NULL')::float::bigint,
    NULL AS provider_id,
    NULL AS care_site_id,
    icu_type_source_value AS visit_detail_source_value,
    NULL AS visit_detail_source_concept_id,
    NULL AS admitted_from_concept_id,
    NULL AS admitted_from_source_value,
    NULL AS discharged_to_concept_id,
    NULL AS discharged_to_source_value,
    NULL AS preceding_visit_detail_id,
    NULL AS parent_visit_detail_id,
    NULLIF(vd.visit_occurrence_id, 'NULL')::float::bigint
FROM
    omopcdm.src_visit_detail AS vd
    JOIN persist.date_shift AS ds ON vd.person_id::float::bigint = ds.person_id
WHERE visit_start_date IS NOT NULL and visit_end_date IS NOT NULL;

INSERT INTO
    omopcdm.visit_occurrence
SELECT
    vo.visit_occurrence_id::float::bigint,
    vo.person_id::float::bigint,
    vo.visit_concept_id::float::bigint,
    vo.visit_start_date::date + INTERVAL'1 day'*ds.days AS visit_start_date,
    vo.visit_start_date::timestamp + INTERVAL'1 day'*ds.days  AS visit_start_datetime,
    vo.visit_end_date::date + INTERVAL'1 day'*ds.days AS visit_end_date,
    vo.visit_end_date::timestamp + INTERVAL'1 day'*ds.days  AS visit_end_datetime,
    vo.visit_type_concept_id::float::bigint,
    NULL AS provider_id,
   NULL AS care_site_id,
    visit_source_value,
    NULL AS visit_source_concept_id,
    NULL AS admitted_from_concept_id,
    NULL AS admitted_from_source_value,
    NULL AS discharged_to_concept_id,
    NULL AS discharged_to_source_value,
    NULL AS preceding_visit_occurrence_id
FROM
    omopcdm.src_visit_occurrence AS vo
    JOIN persist.date_shift AS ds ON vo.person_id::float::bigint = ds.person_id
WHERE visit_start_date IS NOT NULL AND visit_end_date IS NOT NULL;


INSERT INTO
    omopcdm.cdm_source (
        cdm_source_name,
        cdm_source_abbreviation,
        cdm_holder,
        source_description,
        source_documentation_reference,
        cdm_etl_reference,
        source_release_date,
        cdm_release_date,
        cdm_version,
        cdm_version_concept_id,
        vocabulary_version
    )
SELECT
    'MAYO' AS cdm_source_name,
    'MAYO' AS cdm_source_abbreviation,
    'MAYO' AS cdm_holder,
    NULL AS source_description,
    NULL AS source_documentation_reference,
    'https://github.com/chorus-ai/' AS cdm_etl_reference,
    CURRENT_DATE AS source_release_date,
    CURRENT_DATE AS cdm_release_date,
    'v5.4.0' AS cdm_version,
    756265
    /* OMOP CDM Version 5.4.0 */
    AS cdm_version_concept_id,
    (SELECT vocabulary_version FROM vocabulary.vocabulary WHERE vocabulary_id = 'None') AS vocabulary_version;

INSERT INTO
    omopcdm.observation_period
SELECT
    row_number() OVER (order by person_id),
    person_id,
    '2000-01-01'::date AS observation_period_start_date,
    current_date::date AS observation_period_end_date,
    32817
FROM omopcdm.person AS op;