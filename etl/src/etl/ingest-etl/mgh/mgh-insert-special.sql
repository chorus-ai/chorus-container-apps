INSERT INTO
    omopcdm.measurement
SELECT
    m.measurement_id::float::bigint,
    m.person_id::float::bigint,
    m.measurement_concept_id::float::bigint,
    m.measurement_date::date  AS measurement_date,
    m.measurement_datetime::timestamp  AS measurement_datetime,
    m.measurement_time,
    m.measurement_type_concept_id::float::bigint,
    m.operator_concept_id::float::bigint,
    m.value_as_number::float,
    m.value_as_concept_id::float::bigint,
    m.unit_concept_id::float::bigint,
    m.range_low::float,
    m.range_high::float,
    m.provider_id::float::bigint,
    m.visit_occurrence_id::float::bigint,
    m.visit_detail_id::float::bigint,
    measurement_source_value,
    CASE WHEN m.measurement_source_concept_id::float::bigint = 0 THEN NULL
        ELSE m.measurement_source_concept_id::float::bigint
    END AS measurement_source_concept_id,
    unit_source_value,
    unit_source_concept_id::bigint,
    value_source_value,
    m.measurement_event_id::bigint,
    m.meas_event_field_concept_id::bigint
FROM
    omopcdm_20250103_20250116.src_measurement AS m
        INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
    ;

CREATE TABLE persist.valid_persons AS (SELECT distinct(person_id) as pid FROM omopcdm.measurement);

INSERT INTO
    omopcdm.condition_occurrence
SELECT
    co.condition_occurrence_id::float::bigint,
    co.person_id::float::bigint,
    co.condition_concept_id::float::bigint,
    co.condition_start_date::dateAS condition_start_date,
    co.condition_start_datetime::timestampAS condition_start_datetime,
    co.condition_end_date::dateAS condition_end_date,
    co.condition_end_datetime::timestampAS condition_end_datetime,
    co.condition_type_concept_id::float::bigint,
    co.condition_status_concept_id::float::bigint,
    co.stop_reason,
    co.provider_id::float::bigint,
    co.visit_occurrence_id::float::bigint,
    co.visit_detail_id::float::bigint,
    co.condition_source_value AS condition_source_value,
    CASE WHEN co.condition_source_concept_id::float::bigint = 0 THEN NULL
        ELSE co.condition_source_concept_id::float::bigint
    END AS condition_source_concept_id,
    condition_status_source_value
FROM
    omopcdm_20250103_20250116.src_condition_occurrence AS co
        INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
;


INSERT INTO
    omopcdm.death
SELECT
    d.person_id::float::bigint,
    d.death_date::date AS death_date,
    d.death_datetime::timestamp AS death_datetime,
    d.death_type_concept_id::float::bigint,
    d.cause_concept_id::float::bigint,
    cause_source_value,
    CASE WHEN d.cause_source_concept_id::float::bigint = 0 THEN NULL
        ELSE d.cause_source_concept_id::float::bigint
    END AS cause_source_concept_id
FROM
    omopcdm_20250103_20250116.src_death AS d
        INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
;


INSERT INTO
    omopcdm.device_exposure
SELECT
    de.device_exposure_id::float::bigint,
    de.person_id::float::bigint,
    de.device_concept_id::float::bigint,
    de.device_exposure_start_date::date AS device_exposure_start_date,
    de.device_exposure_start_datetime::timestamp AS device_exposure_start_datetime,
    de.device_exposure_end_date::date  AS device_exposure_end_date,
    de.device_exposure_end_datetime::timestamp  AS device_exposure_end_datetime,
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
    omopcdm_20250103_20250116.src_device_exposure AS de
        INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
;

INSERT INTO
    omopcdm.drug_exposure
SELECT
    de.drug_exposure_id::float::bigint,
    de.person_id::float::bigint,
    de.drug_concept_id::float::bigint,
    de.drug_exposure_start_date::date  AS drug_exposure_start_date,
    de.drug_exposure_start_datetime::timestamp  AS drug_exposure_start_datetime,
    COALESCE(de.drug_exposure_end_date::date,de.drug_exposure_start_date::date)  AS drug_exposure_end_date,
    de.drug_exposure_end_datetime::timestamp  AS drug_exposure_end_datetime,
    de.verbatim_end_date::date  AS verbatim_end_date,
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
    omopcdm_20250103_20250116.src_drug_exposure AS de
        INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
WHERE drug_exposure_start_date IS NOT NULL;


INSERT INTO
    omopcdm.observation
SELECT
    o.observation_id::float::bigint,
    o.person_id::float::bigint,
    o.observation_concept_id::float::bigint,
    o.observation_date::date AS observation_date,
    o.observation_datetime::timestamp AS observation_datetime,
    o.observation_type_concept_id::float::bigint,
    o.value_as_number::float,
    o.value_as_string,
    o.value_as_concept_id::float::bigint,
    o.qualifier_concept_id::float::bigint,
    o.unit_concept_id::float::bigint,
    o.provider_id::float::bigint,
    o.visit_occurrence_id::float::bigint,
    o.visit_detail_id::float::bigint,
    o.observation_source_value,
    CASE WHEN o.observation_source_concept_id::float::bigint = 0 THEN NULL
        ELSE o.observation_source_concept_id::float::bigint
    END AS observation_source_concept_id,
    o.unit_source_value,
    o.qualifier_source_value,
    o.value_source_value,
    o.observation_event_id::float::bigint,
    o.obs_event_field_concept_id::float::bigint
FROM
    omopcdm_20250103_20250116.src_observation AS o
    INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint;

INSERT INTO
    omopcdm.observation_period
SELECT
    op.observation_period_id::float::bigint,
    op.person_id::float::bigint,
    op.observation_period_start_date::date AS observation_period_start_date,
    op.observation_period_end_date::date AS observation_period_end_date,
    op.period_type_concept_id::float::bigint
FROM omopcdm_20250103_20250116.src_observation_period AS op
INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint;


WITH
    person_shifted AS (
        SELECT
            p.person_id::float::bigint,
            p.gender_concept_id::float::bigint,
            p.birth_datetime::timestamp AS birth_datetime,
            p.race_concept_id::float::bigint,
            p.ethnicity_concept_id::float::bigint,
            p.location_id::float::bigint,
            p.provider_id::float::bigint,
            p.care_site_id::float::bigint,
            p.gender_source_concept_id::float::bigint,
            p.race_source_concept_id::float::bigint,
            p.ethnicity_source_concept_id::float::bigint,
            p.person_source_value,
            p.gender_source_value,
            p.race_source_value,
            p.ethnicity_source_value
        FROM omopcdm_20250103_20250116.src_person AS p
INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
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
    po.procedure_date::date AS procedure_date,
    po.procedure_datetime::timestamp AS procedure_datetime,
    po.procedure_end_date::date AS procedure_end_date,
    po.procedure_end_datetime::timestamp AS procedure_end_datetime,
    po.procedure_type_concept_id::float::bigint,
    po.modifier_concept_id::float::bigint,
    po.quantity::integer,
    po.provider_id::float::bigint,
    po.visit_occurrence_id::float::bigint,
    po.visit_detail_id::float::bigint,
    po.procedure_source_value,
    CASE WHEN po.procedure_source_concept_id::float::bigint = 0 THEN NULL
        ELSE po.procedure_source_concept_id::float::bigint
    END AS procedure_source_concept_id,
    po.modifier_source_value
FROM
    omopcdm_20250103_20250116.src_procedure_occurrence AS po
INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint;


INSERT INTO
    omopcdm.visit_detail
SELECT
    vd.visit_detail_id::float::bigint,
    vd.person_id::float::bigint,
    vd.visit_detail_concept_id::float::bigint,
    vd.visit_detail_start_date::date AS visit_detail_start_date,
    vd.visit_detail_start_datetime::timestamp AS visit_detail_start_datetime,
    vd.visit_detail_end_date::date AS visit_detail_end_date,
    vd.visit_detail_end_datetime::timestamp AS visit_detail_end_datetime,
    vd.visit_detail_type_concept_id::float::bigint,
    vd.provider_id::float::bigint,
    vd.care_site_id::float::bigint,
    visit_detail_source_value,
    CASE WHEN vd.visit_detail_source_concept_id::float::bigint = 0 THEN NULL
        ELSE vd.visit_detail_source_concept_id::float::bigint
    END AS visit_detail_source_concept_id,
    vd.admitted_from_concept_id::float::bigint,
    vd.admitted_from_source_value,
    vd.discharged_to_source_value::float::bigint,
    vd.discharged_to_concept_id,
    vd.preceding_visit_detail_id::float::bigint,
    vd.parent_visit_detail_id::float::bigint,
    vd.visit_occurrence_id::float::bigint
FROM
    omopcdm_20250103_20250116.src_visit_detail AS vd
INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint;

INSERT INTO
    omopcdm.visit_occurrence
SELECT
    vo.visit_occurrence_id::float::bigint,
    vo.person_id::float::bigint,
    vo.visit_concept_id::float::bigint,
    vo.visit_start_date::date AS visit_start_date,
    vo.visit_start_datetime::timestamp  AS visit_start_datetime,
    vo.visit_end_date::date AS visit_end_date,
    vo.visit_end_datetime::timestamp  AS visit_end_datetime,
    vo.visit_type_concept_id::float::bigint,
    vo.provider_id::float::bigint,
    vo.care_site_id::float::bigint,
    visit_source_value,
    CASE WHEN vo.visit_source_concept_id::float::bigint = 0 THEN NULL
        ELSE vo.visit_source_concept_id::float::bigint
    END AS visit_source_concept_id,
    vo.admitted_from_concept_id::float::bigint,
    admitted_from_source_value,
    vo.discharged_to_concept_id::float::bigint,
    discharged_to_source_value,
    vo.preceding_visit_occurrence_id::float::bigint
FROM
    omopcdm_20250103_20250116.src_visit_occurrence AS vo
        INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
;

INSERT INTO
    omopcdm.condition_era
SELECT
    ce.condition_era_id::float::bigint,
    ce.person_id::float::bigint,
    ce.condition_concept_id::float::bigint,
    ce.condition_era_start_date::date  AS condition_era_start_date,
    ce.condition_era_end_date::date  AS condition_era_end_date,
    ce.condition_occurrence_count::float::bigint
FROM
    omopcdm_20250103_20250116.src_condition_era AS ce
INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
;

INSERT INTO
    omopcdm.drug_era
SELECT
    de.drug_era_id::float::bigint,
    de.person_id::float::bigint,
    de.drug_concept_id::float::bigint,
    de.drug_era_start_date::date  AS drug_era_start_date,
    de.drug_era_end_date::date  AS drug_era_end_date,
    de.drug_exposure_count::float::bigint,
    de.gap_days::float::bigint
FROM
    omopcdm_20250103_20250116.src_drug_era AS de
INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
;

INSERT INTO omopcdm.note
SELECT note_id::float::bigint,
    n.person_id::float::bigint,
    note_date::date AS note_date,
    note_datetime::timestamp AS note_datetime,
    note_type_concept_id::float::bigint,
    NULLIF(note_class_concept_id, 'nan')::float::bigint,
    'REDACTED' AS note_title,
    'REDACTED' AS note_text,
    NULLIF(encoding_concept_id, 'nan')::float::bigint,
    NULLIF(language_concept_id, 'nan')::float::bigint,
    NULLIF(provider_id, 'nan')::float::bigint,
    NULLIF(visit_occurrence_id, 'nan')::float::bigint,
    NULLIF(visit_detail_id, 'nan')::float::bigint,
    note_source_value,
    NULLIF(note_event_id, 'nan')::float::bigint,
    NULLIF(note_event_field_concept_id, 'nan')::float::bigint
FROM
omopcdm_20250103_20250116.src_note AS n
INNER JOIN persist.valid_persons vp ON person_id::bigint = pid::bigint
;

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
omopcdm_20250103_20250116.src_note_nlp
WHERE note_id::float::bigint IN (SELECT distinct note_id FROM omopcdm.note); -- no date shift for note nlp, date refers to nlp execution not clinical date


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
    'MGH' AS cdm_source_name,
    'MGH' AS cdm_source_abbreviation,
    'MGH' AS cdm_holder,
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

