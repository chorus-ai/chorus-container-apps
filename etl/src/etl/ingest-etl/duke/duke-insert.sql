INSERT INTO
    omopcdm.condition_occurrence
SELECT
    co.condition_occurrence_id::float::bigint,
    co.person_id::float::bigint,
    co.condition_concept_id::float::bigint,
    co.condition_start_date::date + INTERVAL '1 day'*ds.days AS condition_start_date,
    co.condition_start_datetime::timestamp + INTERVAL '1 day'*ds.days AS condition_start_datetime,
    NULLIF(co.condition_end_date, 'NULL')::date + INTERVAL '1 day'*ds.days AS condition_end_date,
    NULLIF(co.condition_end_datetime, 'NULL')::timestamp + INTERVAL '1 day'*ds.days AS condition_end_datetime,
    NULLIF(co.condition_type_concept_id, 'NULL')::float::bigint,
    NULLIF(co.condition_status_concept_id, 'NULL')::float::bigint,
    co.stop_reason,
    NULLIF(co.provider_id, 'NULL')::float::bigint,
    NULLIF(co.visit_occurrence_id, 'NULL')::float::bigint,
    NULLIF(co.visit_detail_id, 'NULL')::float::bigint,
    co.condition_source_value AS condition_source_value,
    CASE WHEN NULLIF(co.condition_source_concept_id, 'NULL')::float::bigint = 0 THEN NULL
        ELSE NULLIF(co.condition_source_concept_id, 'NULL')::float::bigint
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
    NULLIF(de.device_exposure_end_date, 'NULL')::date + INTERVAL'1 day'*ds.days  AS device_exposure_end_date,
    NULLIF(de.device_exposure_end_datetime, 'NULL')::timestamp + INTERVAL'1 day'*ds.days  AS device_exposure_end_datetime,
    NULLIF(de.device_type_concept_id, 'NULL')::float::bigint,
    unique_device_id,
    NULLIF(de.production_id, 'NULL')::float::bigint,
    NULLIF(de.quantity, 'NULL')::float::bigint,
    NULLIF(de.provider_id, 'NULL')::float::bigint,
    NULLIF(de.visit_occurrence_id, 'NULL')::float::bigint,
    NULLIF(de.visit_detail_id, 'NULL')::float::bigint,
    device_source_value,
    CASE WHEN NULLIF(de.device_source_concept_id, 'NULL')::float::bigint = 0 THEN NULL
        ELSE NULLIF(de.device_source_concept_id, 'NULL')::float::bigint
    END AS device_source_concept_id,
    NULLIF(de.unit_concept_id, 'NULL')::float::bigint,
    unit_source_value,
    NULLIF(unit_source_concept_id, 'NULL')::float::bigint
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
    COALESCE(NULLIF(de.drug_exposure_end_date, 'NULL')::date,de.drug_exposure_start_date::date) + INTERVAL'1 day'*ds.days  AS drug_exposure_end_date,
    NULLIF(de.drug_exposure_end_datetime, 'NULL')::timestamp + INTERVAL'1 day'*ds.days  AS drug_exposure_end_datetime,
    NULLIF(de.verbatim_end_date, 'NULL')::date + INTERVAL'1 day'*ds.days  AS verbatim_end_date,
    NULLIF(de.drug_type_concept_id, 'NULL')::float::bigint,
    de.stop_reason,
    NULLIF(de.refills, 'NULL')::float::integer,
    NULLIF(de.quantity, 'NULL')::float,
    NULLIF(de.days_supply, 'NULL')::float::integer,
    de.sig,
    NULLIF(de.route_concept_id, 'NULL')::float::bigint,
    de.lot_number,
    NULLIF(de.provider_id, 'NULL')::float::bigint,
    NULLIF(de.visit_occurrence_id, 'NULL')::float::bigint,
    NULLIF(de.visit_detail_id, 'NULL')::float::bigint,
    drug_source_value,
    CASE WHEN NULLIF(de.drug_source_concept_id, 'NULL')::float::bigint = 0 THEN NULL
        ELSE NULLIF(de.drug_source_concept_id, 'NULL')::float::bigint
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
    NULLIF(m.measurement_datetime, 'NULL')::timestamp + INTERVAL'1 day'*ds.days  AS measurement_datetime,
    m.measurement_time,
    NULLIF(m.measurement_type_concept_id, 'NULL')::float::bigint,
    NULLIF(m.operator_concept_id, 'NULL')::float::bigint,
    NULLIF(m.value_as_number, 'NULL')::float,
    NULLIF(m.value_as_concept_id, 'NULL')::float::bigint,
   NULLIF( m.unit_concept_id, 'NULL')::float::bigint,
    NULLIF(m.range_low, 'NULL')::float,
    NULLIF(m.range_high, 'NULL')::float,
    NULLIF(m.provider_id, 'NULL')::float::bigint,
    NULLIF(m.visit_occurrence_id, 'NULL')::float::bigint,
    NULLIF(m.visit_detail_id, 'NULL')::float::bigint,
    measurement_source_value,
    CASE WHEN NULLIF(m.measurement_source_concept_id, 'NULL')::float::bigint = 0 THEN NULL
        ELSE NULLIF(m.measurement_source_concept_id, 'NULL')::float::bigint
    END AS measurement_source_concept_id,
    unit_source_value,
    NULLIF(unit_source_concept_id, 'NULL')::bigint,
    value_source_value,
    NULLIF(m.measurement_event_id, 'NULL')::bigint,
    NULLIF(m.meas_event_field_concept_id, 'NULL')::bigint
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
    NULLIF(o.observation_datetime, 'NULL')::timestamp + INTERVAL'1 day'*ds.days AS observation_datetime,
    NULLIF(o.observation_type_concept_id, 'NULL')::float::bigint,
    NULLIF(o.value_as_number, 'NULL')::float,
    o.value_as_string,
    NULLIF(o.value_as_concept_id, 'NULL')::float::bigint,
    NULLIF(o.qualifier_concept_id, 'NULL')::float::bigint,
    NULLIF(o.unit_concept_id, 'NULL')::float::bigint,
    NULLIF(o.provider_id, 'NULL')::float::bigint,
    NULLIF(o.visit_occurrence_id, 'NULL')::float::bigint,
    NULLIF(o.visit_detail_id, 'NULL')::float::bigint,
    o.observation_source_value,
    CASE WHEN NULLIF(o.observation_source_concept_id, 'NULL')::float::bigint = 0 THEN NULL
        ELSE NULLIF(o.observation_source_concept_id, 'NULL')::float::bigint
    END AS observation_source_concept_id,
    o.unit_source_value,
    o.qualifier_source_value,
    o.value_source_value,
   NULLIF( o.observation_event_id, 'NULL')::float::bigint,
    NULLIF(o.obs_event_field_concept_id, 'NULL')::float::bigint
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
            NULLIF(p.birth_datetime, 'NULL')::timestamp + INTERVAL'1 day'*ds.days AS birth_datetime,
            NULLIF(p.race_concept_id, 'NULL')::float::bigint race_concept_id,
            NULLIF(p.ethnicity_concept_id, 'NULL')::float::bigint ethnicity_concept_id,
            NULLIF(p.location_id, 'NULL')::float::bigint location_id,
            NULLIF(p.provider_id, 'NULL')::float::bigint provider_id,
            NULLIF(p.care_site_id, 'NULL')::float::bigint care_site_id,
            NULLIF(p.gender_source_concept_id, 'NULL')::float::bigint gender_source_concept_id,
            NULLIF(p.race_source_concept_id, 'NULL')::float::bigint race_source_concept_id,
            NULLIF(p.ethnicity_source_concept_id, 'NULL')::float::bigint ethnicity_source_concept_id,
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
    NULLIF(po.procedure_end_date, 'NULL')::date + INTERVAL'1 day'*ds.days AS procedure_end_date,
    NULLIF(po.procedure_end_datetime, 'NULL')::timestamp + INTERVAL'1 day'*ds.days AS procedure_end_datetime,
    NULLIF(po.procedure_type_concept_id, 'NULL')::float::bigint,
    NULLIF(po.modifier_concept_id, 'NULL')::float::bigint,
    NULLIF(po.quantity, 'NULL')::integer,
    NULLIF(po.provider_id, 'NULL')::float::bigint,
    NULLIF(po.visit_occurrence_id, 'NULL')::float::bigint,
    NULLIF(po.visit_detail_id, 'NULL')::float::bigint,
    po.procedure_source_value,
    CASE WHEN NULLIF(po.procedure_source_concept_id, 'NULL')::float::bigint = 0 THEN NULL
        ELSE NULLIF(po.procedure_source_concept_id, 'NULL')::float::bigint
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
    NULLIF(vd.visit_detail_type_concept_id, 'NULL')::float::bigint,
    NULLIF(vd.provider_id, 'NULL')::float::bigint,
    NULLIF(vd.care_site_id, 'NULL')::float::bigint,
    visit_detail_source_value,
    CASE WHEN NULLIF(vd.visit_detail_source_concept_id, 'NULL')::float::bigint = 0 THEN NULL
        ELSE NULLIF(vd.visit_detail_source_concept_id, 'NULL')::float::bigint
    END AS visit_detail_source_concept_id,
    NULLIF(vd.admitted_from_concept_id, 'NULL')::float::bigint,
    vd.admitted_from_source_value,
    NULLIF(vd.discharged_to_concept_id, 'NULL')::float::bigint,
    vd.discharged_to_source_value,
    NULLIF(vd.preceding_visit_detail_id, 'NULL')::float::bigint,
    NULLIF(vd.parent_visit_detail_id, 'NULL')::float::bigint,
    NULLIF(vd.visit_occurrence_id, 'NULL')::float::bigint
FROM
    omopcdm.src_visit_detail AS vd
    JOIN persist.date_shift AS ds ON vd.person_id::float::bigint = ds.person_id;

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
    NULLIF(vo.provider_id, 'NULL')::float::bigint,
    NULLIF(vo.care_site_id, 'NULL')::float::bigint,
    visit_source_value,
    CASE WHEN NULLIF(vo.visit_source_concept_id, 'NULL')::float::bigint = 0 THEN NULL
        ELSE NULLIF(vo.visit_source_concept_id, 'NULL')::float::bigint
    END AS visit_source_concept_id,
    NULLIF(vo.admitted_from_concept_id, 'NULL')::float::bigint,
    admitted_from_source_value,
    NULLIF(vo.discharged_to_concept_id, 'NULL')::float::bigint,
    discharged_to_source_value,
    NULLIF(vo.preceding_visit_occurrence_id, 'NULL')::float::bigint
FROM
    omopcdm.src_visit_occurrence AS vo
    JOIN persist.date_shift AS ds ON vo.person_id::float::bigint = ds.person_id;

INSERT INTO
    omopcdm.condition_era
SELECT
    ce.condition_era_id::float::bigint,
    ce.person_id::float::bigint,
    ce.condition_concept_id::float::bigint,
    ce.condition_era_start_date::date + INTERVAL'1 day'*ds.days  AS condition_era_start_date,
    ce.condition_era_end_date::date + INTERVAL'1 day'*ds.days  AS condition_era_end_date,
    ce.condition_occurrence_count::float::bigint
FROM
    omopcdm.src_condition_era AS ce
    JOIN persist.date_shift AS ds ON ce.person_id::float::bigint = ds.person_id;

INSERT INTO
    omopcdm.drug_era
SELECT
    de.drug_era_id::float::bigint,
    de.person_id::float::bigint,
    de.drug_concept_id::float::bigint,
    de.drug_era_start_date::date + INTERVAL'1 day'*ds.days  AS drug_era_start_date,
    de.drug_era_end_date::date + INTERVAL'1 day'*ds.days  AS drug_era_end_date,
    de.drug_exposure_count::float::bigint,
    de.gap_days::float::bigint
FROM
    omopcdm.src_drug_era AS de
    JOIN persist.date_shift AS ds ON de.person_id::float::bigint = ds.person_id;


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
    'DUKE' AS cdm_source_name,
    'DUKE' AS cdm_source_abbreviation,
    'DUKE' AS cdm_holder,
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

