INSERT INTO
    omopcdm.condition_occurrence
SELECT
    co.condition_occurrence_id::float::bigint,
    co.person_id::float::bigint,
    co.condition_concept_id::float::bigint,
    co.condition_start_date::date + INTERVAL '1 day'*ds.days AS condition_start_date,
    co.condition_start_datetime::timestamp + INTERVAL '1 day'*ds.days AS condition_start_datetime,
    co.condition_end_date::date + INTERVAL '1 day'*ds.days AS condition_end_date,
    co.condition_end_datetime::timestamp + INTERVAL '1 day'*ds.days AS condition_end_datetime,
    co.condition_type_concept_id::float::bigint,
    NULLIF(co.condition_status_concept_id, 'nan')::float::bigint,
    co.stop_reason,
    co.provider_id::float::bigint,
    co.visit_occurrence_id::float::bigint,
    co.visit_detail_id::float::bigint,
    co.condition_source_value AS condition_source_value,
    CASE WHEN NULLIF(co.condition_source_concept_id, 'nan')::float::bigint = 0 THEN NULL
        ELSE NULLIF(co.condition_source_concept_id, 'nan')::float::bigint
    END AS condition_source_concept_id,
    condition_status_source_value
FROM
    omopcdm.src_condition_occurrence AS co
    JOIN persist.date_shift AS ds ON co.person_id::float::bigint = ds.person_id;


INSERT INTO
    omopcdm.death
SELECT
    d.person_id::float::bigint,
    d.death_date::date + INTERVAL '1 day'*ds.days AS death_date,
    d.death_datetime::timestamp + INTERVAL '1 day'*ds.days AS death_datetime,
    d.death_type_concept_id::float::bigint,
    d.cause_concept_id::float::bigint,
    cause_source_value,
    CASE WHEN d.cause_source_concept_id::float::bigint = 0 THEN NULL
        ELSE d.cause_source_concept_id::float::bigint
    END AS cause_source_concept_id
FROM
    omopcdm.src_death AS d
    JOIN persist.date_shift AS ds ON d.person_id::float::bigint = ds.person_id;


INSERT INTO
    omopcdm.device_exposure
SELECT
    de.device_exposure_id::float::bigint,
    de.person_id::float::bigint,
    de.device_concept_id::float::bigint,
    de.device_exposure_start_date::date + INTERVAL'1 day'*ds.days AS device_exposure_start_date,
    de.device_exposure_start_datetime::timestamp + INTERVAL'1 day'*ds.days AS device_exposure_start_datetime,
    de.device_exposure_end_date::date + INTERVAL'1 day'*ds.days  AS device_exposure_end_date,
    de.device_exposure_end_datetime::timestamp + INTERVAL'1 day'*ds.days  AS device_exposure_end_datetime,
    de.device_type_concept_id::float::bigint,
    unique_device_id,
    de.production_id::float::bigint,
    de.quantity::float::bigint,
    de.provider_id::float::bigint,
    de.visit_occurrence_id::float::bigint,
    de.visit_detail_id::float::bigint,
    device_source_value,
    CASE WHEN de.device_source_concept_id::float::bigint = 0 THEN NULL
        ELSE de.device_source_concept_id::float::bigint
    END AS device_source_concept_id,
    de.unit_concept_id::float::bigint,
    unit_source_value,
    unit_source_concept_id::float::bigint
FROM
    omopcdm.src_device_exposure AS de
    JOIN persist.date_shift AS ds ON de.person_id::float::bigint = ds.person_id;

INSERT INTO
    omopcdm.drug_exposure
SELECT
    de.drug_exposure_id::float::bigint,
    de.person_id::float::bigint,
    de.drug_concept_id::float::bigint,
    de.drug_exposure_start_date::date + INTERVAL'1 day'*ds.days  AS drug_exposure_start_date,
    de.drug_exposure_start_datetime::timestamp + INTERVAL'1 day'*ds.days  AS drug_exposure_start_datetime,
    COALESCE(de.drug_exposure_end_date::date,de.drug_exposure_start_date::date) + INTERVAL'1 day'*ds.days  AS drug_exposure_end_date,
    de.drug_exposure_end_datetime::timestamp + INTERVAL'1 day'*ds.days  AS drug_exposure_end_datetime,
    de.verbatim_end_date::date + INTERVAL'1 day'*ds.days  AS verbatim_end_date,
    de.drug_type_concept_id::float::bigint,
    de.stop_reason,
    de.refills::float::integer,
    de.quantity::float,
    de.days_supply::float::integer,
    de.sig,
    de.route_concept_id::float::bigint,
    de.lot_number,
    de.provider_id::float::bigint,
    de.visit_occurrence_id::float::bigint,
    de.visit_detail_id::float::bigint,
    drug_source_value,
    CASE WHEN de.drug_source_concept_id::float::bigint = 0 THEN NULL
        ELSE de.drug_source_concept_id::float::bigint
    END AS drug_source_concept_id,
    route_source_value,
    dose_unit_source_value
FROM
    omopcdm.src_drug_exposure AS de
    JOIN persist.date_shift AS ds ON de.person_id::float::bigint = ds.person_id
WHERE drug_exposure_start_date IS NOT NULL;


INSERT INTO
    omopcdm.measurement
SELECT
    m.measurement_id::float::bigint,
    m.person_id::float::bigint,
    m.measurement_concept_id::float::bigint,
    m.measurement_date::date + INTERVAL'1 day'*ds.days  AS measurement_date,
    m.measurement_datetime::timestamp + INTERVAL'1 day'*ds.days  AS measurement_datetime,
    m.measurement_time,
    m.measurement_type_concept_id::float::bigint,
    NULLIF(m.operator_concept_id, 'nan')::float::bigint,
    m.value_as_number::float,
    NULLIF(m.value_as_concept_id, 'nan')::float::bigint,
    NULLIF(m.unit_concept_id, 'nan')::float::bigint,
    m.range_low::float,
    m.range_high::float,
    NULLIF(m.provider_id, 'nan')::float::bigint,
    NULLIF(m.visit_occurrence_id, 'nan')::float::bigint,
    NULLIF(m.visit_detail_id, 'nan')::float::bigint,
    measurement_source_value,
    CASE WHEN NULLIF(m.measurement_source_concept_id, 'nan')::float::bigint = 0 THEN NULL
        ELSE NULLIF(m.measurement_source_concept_id, 'nan')::float::bigint
    END AS measurement_source_concept_id,
    unit_source_value,
    NULLIF(unit_source_concept_id, 'nan')::bigint,
    value_source_value,
    m.measurement_event_id::bigint,
    m.meas_event_field_concept_id::bigint
FROM
    omopcdm.src_measurement AS m
    JOIN persist.date_shift AS ds ON m.person_id::float::bigint = ds.person_id;


INSERT INTO
    omopcdm.observation
SELECT
    o.observation_id::float::bigint,
    o.person_id::float::bigint,
    o.observation_concept_id::float::bigint,
    o.observation_date::date + INTERVAL'1 day'*ds.days AS observation_date,
    o.observation_datetime::timestamp + INTERVAL'1 day'*ds.days AS observation_datetime,
    o.observation_type_concept_id::float::bigint,
    o.value_as_number::float,
    o.value_as_string,
    NULLIF(o.value_as_concept_id, 'nan')::float::bigint,
    NULLIF(o.qualifier_concept_id, 'nan')::float::bigint,
    NULLIF(o.unit_concept_id, 'nan')::float::bigint,
    NULLIF(o.provider_id, 'nan')::float::bigint,
    NULLIF(o.visit_occurrence_id, 'nan')::float::bigint,
    NULLIF(o.visit_detail_id, 'nan')::float::bigint,
    o.observation_source_value,
    CASE WHEN NULLIF(o.observation_source_concept_id, 'nan')::float::bigint = 0 THEN NULL
        ELSE NULLIF(o.observation_source_concept_id, 'nan')::float::bigint
    END AS observation_source_concept_id,
    o.unit_source_value,
    o.qualifier_source_value,
    o.value_source_value,
    NULLIF(o.observation_event_id, 'nan')::float::bigint,
    NULLIF(o.obs_event_field_concept_id, 'nan')::float::bigint
FROM
    omopcdm.src_observation AS o
    JOIN persist.date_shift AS ds ON o.person_id::float::bigint = ds.person_id;

INSERT INTO
    omopcdm.observation_period
SELECT
    op.observation_period_id::float::bigint,
    op.person_id::float::bigint,
    op.observation_period_start_date::date + INTERVAL'1 day'*ds.days AS observation_period_start_date,
    op.observation_period_end_date::date + INTERVAL'1 day'*ds.days AS observation_period_end_date,
    op.period_type_concept_id::float::bigint
FROM omopcdm.src_observation_period AS op
JOIN persist.date_shift AS ds ON op.person_id::float::bigint = ds.person_id;


WITH
    person_shifted AS (
        SELECT
            p.person_id::float::bigint,
            p.gender_concept_id::float::bigint,
            p.birth_datetime::timestamp + INTERVAL'1 day'*ds.days AS birth_datetime,
            p.race_concept_id::float::bigint,
            p.ethnicity_concept_id::float::bigint,
            NULLIF(p.location_id, 'nan')::float::bigint location_id,
            NULLIF(p.provider_id, 'nan')::float::bigint provider_id,
            NULLIF(p.care_site_id, 'nan')::float::bigint care_site_id,
            NULLIF(p.gender_source_concept_id, 'nan')::float::bigint gender_source_concept_id,
            NULLIF(p.race_source_concept_id, 'nan')::float::bigint race_source_concept_id,
            NULLIF(p.ethnicity_source_concept_id, 'nan')::float::bigint ethnicity_source_concept_id,
            p.person_source_value,
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
    po.procedure_concept_id::float::bigint,
    po.procedure_date::date + INTERVAL'1 day'*ds.days AS procedure_date,
    po.procedure_datetime::timestamp + INTERVAL'1 day'*ds.days AS procedure_datetime,
    po.procedure_end_datetime::date + INTERVAL'1 day'*ds.days AS procedure_end_date, -- missing end_date
    po.procedure_end_datetime::timestamp + INTERVAL'1 day'*ds.days AS procedure_end_datetime,
    po.procedure_type_concept_id::float::bigint,
    NULLIF(po.modifier_concept_id, 'nan')::float::bigint,
    po.quantity::integer,
    NULLIF(po.provider_id, 'nan')::float::bigint,
    NULLIF(po.visit_occurrence_id, 'nan')::float::bigint,
    NULLIF(po.visit_detail_id, 'nan')::float::bigint,
    po.procedure_source_value,
    CASE WHEN NULLIF(po.procedure_source_concept_id, 'nan')::float::bigint = 0 THEN NULL
        ELSE NULLIF(po.procedure_source_concept_id, 'nan')::float::bigint
    END AS procedure_source_concept_id,
    po.modifier_source_value
FROM
    omopcdm.src_procedure_occurrence AS po
    JOIN persist.date_shift AS ds ON po.person_id::float::bigint = ds.person_id;


INSERT INTO
    omopcdm.visit_detail
SELECT
    vd.visit_detail_id::float::bigint,
    vd.person_id::float::bigint,
    vd.visit_detail_concept_id::float::bigint,
    vd.visit_detail_start_date::date + INTERVAL'1 day'*ds.days AS visit_detail_start_date,
    vd.visit_detail_start_datetime::timestamp + INTERVAL'1 day'*ds.days AS visit_detail_start_datetime,
    vd.visit_detail_end_date::date + INTERVAL'1 day'*ds.days AS visit_detail_end_date,
    vd.visit_detail_end_datetime::timestamp + INTERVAL'1 day'*ds.days AS visit_detail_end_datetime,
    vd.visit_detail_type_concept_id::float::bigint,
    NULLIF(vd.provider_id, 'nan')::float::bigint,
    NULLIF(vd.care_site_id, 'nan')::float::bigint,
    visit_detail_source_value,
    CASE WHEN NULLIF(vd.visit_detail_source_concept_id, 'nan')::float::bigint = 0 THEN NULL
        ELSE NULLIF(vd.visit_detail_source_concept_id, 'nan')::float::bigint
    END AS visit_detail_source_concept_id,
    NULLIF(vd.admitted_from_concept_id, 'nan')::float::bigint,
    vd.admitted_from_source_value,
    NULLIF(vd.discharged_to_concept_id, 'nan')::float::bigint,
    vd.discharged_to_source_value,
    NULLIF(vd.preceding_visit_detail_id, 'nan')::float::bigint,
    NULLIF(vd.parent_visit_detail_id, 'nan')::float::bigint,
    NULLIF(vd.visit_occurrence_id, 'nan')::float::bigint
FROM
    omopcdm.src_visit_detail AS vd
    JOIN persist.date_shift AS ds ON vd.person_id::float::bigint = ds.person_id
    WHERE NULLIF(visit_occurrence_id, 'nan') IS NOT NULL;

INSERT INTO
    omopcdm.visit_occurrence
SELECT
    vo.visit_occurrence_id::float::bigint,
    vo.person_id::float::bigint,
    vo.visit_concept_id::float::bigint,
    vo.visit_start_date::date + INTERVAL'1 day'*ds.days AS visit_start_date,
    vo.visit_start_datetime::timestamp + INTERVAL'1 day'*ds.days  AS visit_start_datetime,
    vo.visit_end_date::date + INTERVAL'1 day'*ds.days AS visit_end_date,
    vo.visit_end_datetime::timestamp + INTERVAL'1 day'*ds.days  AS visit_end_datetime,
    vo.visit_type_concept_id::float::bigint,
    NULLIF(vo.provider_id, 'nan')::float::bigint,
    NULLIF(vo.care_site_id, 'nan')::float::bigint,
    visit_source_value,
    CASE WHEN NULLIF(vo.visit_source_concept_id, 'nan')::float::bigint = 0 THEN NULL
        ELSE NULLIF(vo.visit_source_concept_id, 'nan')::float::bigint
    END AS visit_source_concept_id,
    NULLIF(vo.admitted_from_concept_id, 'nan')::float::bigint,
    admitted_from_source_value,
    NULLIF(vo.discharged_to_concept_id, 'nan')::float::bigint,
    discharged_to_source_value,
    NULLIF(vo.preceding_visit_occurrence_id, 'nan')::float::bigint
FROM
    omopcdm.src_visit_occurrence AS vo
    JOIN persist.date_shift AS ds ON vo.person_id::float::bigint = ds.person_id;

INSERT INTO omopcdm.note
SELECT note_id::float::bigint,
    n.person_id::float::bigint,
    note_date::date + INTERVAL'1 day'*ds.days AS note_date,
    note_datetime::timestamp + INTERVAL'1 day'*ds.days AS note_datetime,
    note_type_concept_id::float::bigint,
    NULLIF(note_class_concept_id, 'nan')::float::bigint,
    note_title,
    note_text,
    NULLIF(encoding_concept_id, 'nan')::float::bigint,
    NULLIF(language_concept_id, 'nan')::float::bigint,
    NULLIF(provider_id, 'nan')::float::bigint,
    NULLIF(visit_occurrence_id, 'nan')::float::bigint,
    NULLIF(visit_detail_id, 'nan')::float::bigint,
    note_source_value,
    NULLIF(note_event_id, 'nan')::float::bigint,
    NULLIF(note_event_field_concept_id, 'nan')::float::bigint
FROM
omopcdm.src_note AS n
    JOIN persist.date_shift AS ds ON n.person_id::float::bigint = ds.person_id;

INSERT INTO omopcdm.note_nlp
SELECT note_nlp_id::float::bigint,
    note_id::float::bigint,
    NULLIF(section_concept_id, 'nan')::float::bigint,
    snippet,
    NULLIF("offset", 'nan')::float::bigint,
    'REDACTED' AS lexical_variant,
    NULLIF(note_nlp_concept_id, 'nan')::float::bigint,
    NULLIF(note_nlp_source_concept_id, 'nan')::float::bigint,
    nlp_system,
    nlp_date::date,
    nlp_datetime::timestamp,
    term_exists,
    term_temporal,
    term_modifiers
FROM
omopcdm.src_note_nlp; -- no date shift for note nlp, date refers to nlp execution not clinical date

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
    'FLORIDA' AS cdm_source_name,
    'FLORIDA' AS cdm_source_abbreviation,
    'FLORIDA' AS cdm_holder,
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

