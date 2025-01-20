-- INSERT INTO
--     omopcdm.care_site
-- SELECT
--     CAST(care_site_id::FLOAT AS BIGINT),
--     CAST(care_site_name AS TEXT),
--     CAST(place_of_service_concept_id::FLOAT AS BIGINT),
--     CAST(location_id::FLOAT AS BIGINT),
--     CAST(care_site_source_value AS TEXT),
--     CAST(place_of_service_source_value AS TEXT)
-- FROM
--     omopcdm.src_care_site;

INSERT INTO
    omopcdm.condition_era (
        condition_era_id,
        person_id,
        condition_concept_id,
        condition_era_start_date,
        condition_era_end_date,
        condition_occurrence_count
    )
SELECT
    CAST(condition_era_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(condition_concept_id::FLOAT AS BIGINT),
    CAST(condition_era_start_date AS DATE),
    CAST(condition_era_end_date AS DATE),
    CAST(condition_occurrence_count::FLOAT AS BIGINT)
FROM
    omopcdm.src_condition_era;

INSERT INTO
    omopcdm.condition_occurrence (
        condition_occurrence_id,
        person_id,
        condition_concept_id,
        condition_start_date,
        condition_start_datetime,
        condition_end_date,
        condition_end_datetime,
        condition_type_concept_id,
        condition_status_concept_id,
        stop_reason,
        provider_id,
        visit_occurrence_id,
        visit_detail_id,
        condition_source_value,
        condition_source_concept_id,
        condition_status_source_value
    )
SELECT
    CAST(condition_occurrence_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(condition_concept_id::FLOAT AS BIGINT),
    CAST(condition_start_date AS DATE),
    CAST(condition_start_datetime AS TIMESTAMP),
    CAST(condition_end_date AS DATE),
    CAST(condition_end_datetime AS TIMESTAMP),
    CAST(condition_type_concept_id::FLOAT AS BIGINT),
    CAST(condition_status_concept_id::FLOAT AS BIGINT),
    CAST(stop_reason AS TEXT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(visit_occurrence_id::FLOAT AS BIGINT),
    CAST(visit_detail_id::FLOAT AS BIGINT),
    CAST(condition_source_value AS TEXT),
    CAST(condition_source_concept_id::FLOAT AS BIGINT),
    CAST(condition_status_source_value AS TEXT)
FROM
    omopcdm.src_condition_occurrence;

INSERT INTO
    omopcdm.death (
        person_id,
        death_date,
        death_datetime,
        death_type_concept_id,
        cause_concept_id,
        cause_source_value,
        cause_source_concept_id
    )
SELECT
    CAST(person_id::FLOAT AS BIGINT),
    CAST(death_date AS DATE),
    CAST(death_datetime AS TIMESTAMP),
    CAST(death_type_concept_id::FLOAT AS BIGINT),
    CAST(cause_concept_id::FLOAT AS BIGINT),
    CAST(cause_source_value AS TEXT),
    CAST(cause_source_concept_id::FLOAT AS BIGINT)
FROM
    omopcdm.src_death;

INSERT INTO
    omopcdm.device_exposure (
        device_exposure_id,
        person_id,
        device_concept_id,
        device_exposure_start_date,
        device_exposure_start_datetime,
        device_exposure_end_date,
        device_exposure_end_datetime,
        device_type_concept_id,
        unique_device_id,
        production_id,
        quantity,
        provider_id,
        visit_occurrence_id,
        visit_detail_id,
        device_source_value,
        device_source_concept_id,
        unit_concept_id,
        unit_source_value,
        unit_source_concept_id
    )
SELECT
    CAST(device_exposure_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(device_concept_id::FLOAT AS BIGINT),
    CAST(device_exposure_start_date AS DATE),
    CAST(device_exposure_start_datetime AS TIMESTAMP),
    CAST(device_exposure_end_date AS DATE),
    CAST(device_exposure_end_datetime AS TIMESTAMP),
    CAST(device_type_concept_id::FLOAT AS BIGINT),
    CAST(unique_device_id AS TEXT),
    CAST(NULL AS TEXT) AS production_id,
    CAST(quantity::FLOAT AS BIGINT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(visit_occurrence_id::FLOAT AS BIGINT),
    CAST(visit_detail_id::FLOAT AS BIGINT),
    CAST(device_source_value::FLOAT AS BIGINT),
    CAST(device_source_concept_id::FLOAT AS BIGINT),
    CAST(NULL::FLOAT AS BIGINT) AS unit_concept_id,
    CAST(NULL AS TEXT) AS unit_source_value,
    CAST(NULL::FLOAT AS BIGINT) AS unit_source_concept_id
FROM
    omopcdm.src_device_exposure;

INSERT INTO
    omopcdm.dose_era (
        dose_era_id,
        person_id,
        drug_concept_id,
        unit_concept_id,
        dose_value,
        dose_era_start_date,
        dose_era_end_date
    )
SELECT
    CAST(dose_era_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(drug_concept_id::FLOAT AS BIGINT),
    CAST(unit_concept_id::FLOAT AS BIGINT),
    CAST(dose_value AS FLOAT),
    CAST(dose_era_start_date AS DATE),
    CAST(dose_era_end_date AS DATE)
FROM
    omopcdm.src_dose_era;

INSERT INTO
    omopcdm.drug_era (
        drug_era_id,
        person_id,
        drug_concept_id,
        drug_era_start_date,
        drug_era_end_date,
        drug_exposure_count,
        gap_days
    )
SELECT
    CAST(drug_era_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(drug_concept_id::FLOAT AS BIGINT),
    CAST(drug_era_start_date AS DATE),
    CAST(drug_era_end_date AS DATE),
    CAST(drug_exposure_count::FLOAT AS BIGINT),
    CAST(gap_days::FLOAT AS BIGINT)
FROM
    omopcdm.src_drug_era;

INSERT INTO
    omopcdm.drug_exposure (
        drug_exposure_id,
        person_id,
        drug_concept_id,
        drug_exposure_start_date,
        drug_exposure_start_datetime,
        drug_exposure_end_date,
        drug_exposure_end_datetime,
        verbatim_end_date,
        drug_type_concept_id,
        stop_reason,
        refills,
        quantity,
        days_supply,
        sig,
        route_concept_id,
        lot_number,
        provider_id,
        visit_occurrence_id,
        visit_detail_id,
        drug_source_value,
        drug_source_concept_id,
        route_source_value,
        dose_unit_source_value
    )
SELECT
    CAST(drug_exposure_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(drug_concept_id::FLOAT AS BIGINT),
    CAST(drug_exposure_start_date AS DATE),
    CAST(drug_exposure_start_datetime AS TIMESTAMP),
    CAST(drug_exposure_end_date AS DATE),
    CAST(drug_exposure_end_datetime AS TIMESTAMP),
    CAST(verbatim_end_date AS DATE),
    CAST(drug_type_concept_id::FLOAT AS BIGINT),
    CAST(stop_reason AS TEXT),
    CAST(refills::FLOAT AS BIGINT),
    CAST(quantity AS FLOAT),
    CAST(days_supply::FLOAT AS BIGINT),
    CAST(sig AS TEXT),
    CAST(route_concept_id::FLOAT AS BIGINT),
    CAST(lot_number AS TEXT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(visit_occurrence_id::FLOAT AS BIGINT),
    CAST(visit_detail_id::FLOAT AS BIGINT),
    CAST(drug_source_value AS TEXT),
    CAST(drug_source_concept_id::FLOAT AS BIGINT),
    CAST(route_source_value AS TEXT),
    CAST(dose_unit_source_value AS TEXT)
FROM
    omopcdm.src_drug_exposure;

INSERT INTO
    omopcdm.measurement (
        measurement_id,
        person_id,
        measurement_concept_id,
        measurement_date,
        measurement_datetime,
        measurement_time,
        measurement_type_concept_id,
        operator_concept_id,
        value_as_number,
        value_as_concept_id,
        unit_concept_id,
        range_low,
        range_high,
        provider_id,
        visit_occurrence_id,
        visit_detail_id,
        measurement_source_value,
        measurement_source_concept_id,
        unit_source_value,
        unit_source_concept_id,
        value_source_value,
        measurement_event_id,
        meas_event_field_concept_id
                )
SELECT
    CAST(measurement_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(measurement_concept_id::FLOAT AS BIGINT),
    CAST(measurement_date AS DATE),
    CAST(measurement_datetime AS TIMESTAMP),
    CAST(measurement_time AS TEXT),
    CAST(measurement_type_concept_id::FLOAT AS BIGINT),
    CAST(operator_concept_id::FLOAT AS BIGINT),
    CAST(value_as_number AS FLOAT),
    CAST(value_as_concept_id::FLOAT AS BIGINT),
    CAST(unit_concept_id::FLOAT AS BIGINT),
    CAST(range_low AS FLOAT),
    CAST(range_high AS FLOAT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(visit_occurrence_id::FLOAT AS BIGINT),
    CAST(visit_detail_id::FLOAT AS BIGINT),
    CAST(measurement_source_value AS TEXT),
    CAST(measurement_source_concept_id::FLOAT AS BIGINT),
    CAST(unit_source_value AS TEXT),
    CAST(NULL::FLOAT AS BIGINT) AS unit_source_concept_id,
    CAST(value_source_value AS TEXT),
    CAST(NULL::FLOAT AS BIGINT) AS measurement_event_id,
    CAST(NULL::FLOAT AS BIGINT) AS meas_event_field_concept_id
FROM
    omopcdm.src_measurement;

INSERT INTO
    omopcdm.note (
        note_id,
        person_id,
        note_date,
        note_datetime,
        note_type_concept_id,
        note_class_concept_id,
        note_title,
        note_text,
        encoding_concept_id,
        language_concept_id,
        provider_id,
        visit_occurrence_id,
        visit_detail_id,
        note_source_value,
        note_event_id,
        note_event_field_concept_id
         )
SELECT CAST(note_id::FLOAT AS BIGINT),
       CAST(person_id::FLOAT AS BIGINT),
       CAST(note_date AS DATE),
       CAST(note_datetime AS TIMESTAMP),
       CAST(note_type_concept_id::FLOAT AS BIGINT),
       CAST(note_class_concept_id::FLOAT AS BIGINT),
       CAST(note_title AS TEXT),
       CAST(note_text AS TEXT),
       CAST(encoding_concept_id::FLOAT AS BIGINT),
       CAST(language_concept_id::FLOAT AS BIGINT),
       CAST(provider_id::FLOAT AS BIGINT),
       CAST(visit_occurrence_id::FLOAT AS BIGINT),
       CAST(visit_detail_id::FLOAT AS BIGINT),
       CAST(note_source_value AS TEXT),
       CAST(NULL::FLOAT AS BIGINT) AS note_event_id,
       CAST(NULL::FLOAT AS BIGINT) AS note_event_field_concept_id
FROM omopcdm.src_note;


INSERT INTO
    omopcdm.note_nlp (
                 note_nlp_id,
                 note_id,
                 section_concept_id,
                 snippet,
                 offset,
                 lexical_variant,
                 note_nlp_concept_id,
                 note_nlp_source_concept_id,
                 nlp_system,
                 nlp_date,
                 nlp_datetime,
                 term_exists,
                 term_temporal,
                 term_modifiers
             )
SELECT CAST(note_nlp_id AS INTEGER),
       CAST(note_id AS INTEGER),
       CAST(section_concept_id AS INTEGER),
       CAST(snippet AS TEXT),
       CAST(offset AS TEXT),
       CAST(lexical_variant AS TEXT),
       CAST(note_nlp_concept_id AS INTEGER),
       CAST(note_nlp_source_concept_id AS INTEGER),
       CAST(nlp_system AS TEXT),
       CAST(nlp_date AS DATE),
       CAST(nlp_datetime AS TIMESTAMP),
       CAST(term_exists AS TEXT),
       CAST(term_temporal AS TEXT),
       CAST(term_modifiers AS TEXT)
FROM omopcdm.src_note_nlp;

INSERT INTO
    omopcdm.observation (
        observation_id,
        person_id,
        observation_concept_id,
        observation_date,
        observation_datetime,
        observation_type_concept_id,
        value_as_number,
        value_as_string,
        value_as_concept_id,
        qualifier_concept_id,
        unit_concept_id,
        provider_id,
        visit_occurrence_id,
        visit_detail_id,
        observation_source_value,
        observation_source_concept_id,
        unit_source_value,
        qualifier_source_value,
        value_source_value,
        observation_event_id,
        obs_event_field_concept_id
    )
SELECT
    CAST(observation_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(observation_concept_id::FLOAT AS BIGINT),
    CAST(observation_date AS DATE),
    CAST(observation_datetime AS TIMESTAMP),
    CAST(observation_type_concept_id::FLOAT AS BIGINT),
    CAST(value_as_number AS FLOAT),
    CAST(NULL AS TEXT) AS value_as_string,
    CAST(value_as_concept_id::FLOAT AS BIGINT),
    CAST(qualifier_concept_id::FLOAT AS BIGINT),
    CAST(unit_concept_id::FLOAT AS BIGINT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(visit_occurrence_id::FLOAT AS BIGINT),
    CAST(visit_detail_id::FLOAT AS BIGINT),
    CAST(observation_source_value AS TEXT),
    CAST(observation_source_concept_id::FLOAT AS BIGINT),
    CAST(unit_source_value AS TEXT),
    CAST(qualifier_source_value AS TEXT),
    CAST(NULL AS TEXT) AS value_source_value,
    CAST(NULL::FLOAT AS BIGINT) AS observation_event_id,
    CAST(NULL::FLOAT AS BIGINT) AS obs_event_field_concept_id
FROM
    omopcdm.src_observation;

INSERT INTO
    omopcdm.observation_period (
        observation_period_id,
        person_id,
        observation_period_start_date,
        observation_period_end_date,
        period_type_concept_id
    )
SELECT
    CAST(observation_period_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(observation_period_start_date AS DATE),
    CAST(observation_period_end_date AS DATE),
    CAST(period_type_concept_id::FLOAT AS BIGINT)
FROM
    omopcdm.src_observation_period;

INSERT INTO
    omopcdm.person (
        person_id,
        gender_concept_id,
        year_of_birth,
        month_of_birth,
        day_of_birth,
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
    )
SELECT
    CAST(person_id::FLOAT AS BIGINT),
    CAST(gender_concept_id::FLOAT AS BIGINT),
    CAST(year_of_birth::FLOAT AS BIGINT),
    CAST(month_of_birth::FLOAT AS BIGINT),
    CAST(day_of_birth::FLOAT AS BIGINT),
    CAST(birth_datetime AS TIMESTAMP),
    CAST(race_concept_id::FLOAT AS BIGINT),
    CAST(ethnicity_concept_id::FLOAT AS BIGINT),
    CAST(location_id::FLOAT AS BIGINT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(care_site_id::FLOAT AS BIGINT),
    CAST(person_source_value AS TEXT),
    CAST(gender_source_value AS TEXT),
    CAST(gender_source_concept_id::FLOAT AS BIGINT),
    CAST(race_source_value AS TEXT),
    CAST(race_source_concept_id::FLOAT AS BIGINT),
    CAST(ethnicity_source_value AS TEXT),
    CAST(ethnicity_source_concept_id::FLOAT AS BIGINT)
FROM
   omopcdm.src_person;

INSERT INTO
    omopcdm.procedure_occurrence (
        procedure_occurrence_id,
        person_id,
        procedure_concept_id,
        procedure_date,
        procedure_datetime,
        procedure_end_date,
        procedure_end_datetime,
        procedure_type_concept_id,
        modifier_concept_id,
        quantity,
        provider_id,
        visit_occurrence_id,
        visit_detail_id,
        procedure_source_value,
        procedure_source_concept_id,
        modifier_source_value
    )
SELECT
    CAST(procedure_occurrence_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(procedure_concept_id::FLOAT AS BIGINT),
    CAST(procedure_date AS DATE),
    CAST(procedure_datetime AS TIMESTAMP),
    CAST(NULL AS DATE) AS procedure_end_date,
    CAST(NULL AS TIMESTAMP) AS procedure_end_datetime,
    CAST(procedure_type_concept_id::FLOAT AS BIGINT),
    CAST(modifier_concept_id::FLOAT AS BIGINT),
    CAST(quantity AS FLOAT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(visit_occurrence_id::FLOAT AS BIGINT),
    CAST(visit_detail_id::FLOAT AS BIGINT),
    CAST(procedure_source_value AS TEXT),
    CAST(procedure_source_concept_id::FLOAT AS BIGINT),
    CAST(modifier_source_value AS TEXT)
FROM
    omopcdm.src_procedure_occurrence;

INSERT INTO
    omopcdm.specimen (
        specimen_id,
        person_id,
        specimen_concept_id,
        specimen_type_concept_id,
        specimen_date,
        specimen_datetime,
        quantity,
        unit_concept_id,
        anatomic_site_concept_id,
        disease_status_concept_id,
        specimen_source_id,
        specimen_source_value,
        unit_source_value,
        anatomic_site_source_value,
        disease_status_source_value
    )
SELECT
    CAST(specimen_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(specimen_concept_id::FLOAT AS BIGINT),
    CAST(specimen_type_concept_id::FLOAT AS BIGINT),
    CAST(specimen_date AS DATE),
    CAST(specimen_datetime AS TIMESTAMP),
    CAST(quantity AS FLOAT),
    CAST(unit_concept_id::FLOAT AS BIGINT),
    CAST(anatomic_site_concept_id::FLOAT AS BIGINT),
    CAST(disease_status_concept_id::FLOAT AS BIGINT),
    CAST(NULL::FLOAT AS BIGINT) AS specimen_source_id,
    CAST(specimen_source_value AS TEXT),
    CAST(unit_source_value AS TEXT),
    CAST(anatomic_site_source_value AS TEXT),
    CAST(disease_status_source_value AS TEXT)
FROM
    omopcdm.src_specimen;

INSERT INTO
    omopcdm.visit_detail (
        visit_detail_id,
        person_id,
        visit_detail_concept_id,
        visit_detail_start_date,
        visit_detail_start_datetime,
        visit_detail_end_date,
        visit_detail_end_datetime,
        visit_detail_type_concept_id,
        provider_id,
        care_site_id,
        visit_detail_source_value,
        visit_detail_source_concept_id,
        admitted_from_concept_id,
        admitted_from_source_value,
        discharged_to_concept_id,
        discharged_to_source_value,
        preceding_visit_detail_id,
        parent_visit_detail_id,
        visit_occurrence_id
    )
SELECT
    CAST(visit_detail_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(visit_detail_concept_id::FLOAT AS BIGINT),
    CAST(visit_detail_start_date AS DATE),
    CAST(visit_detail_start_datetime AS TIMESTAMP),
    CAST(visit_detail_end_date AS DATE),
    CAST(visit_detail_end_datetime AS TIMESTAMP),
    CAST(visit_detail_type_concept_id::FLOAT AS BIGINT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(care_site_id::FLOAT AS BIGINT),
    CAST(visit_detail_source_value AS TEXT),
    CAST(visit_detail_source_concept_id::FLOAT AS BIGINT),
    CAST(admitting_source_concept_id::FLOAT AS BIGINT),
    CAST(admitting_source_value AS TEXT),
    CAST(discharge_to_concept_id::FLOAT AS BIGINT),
    CAST(discharge_to_source_value AS TEXT),
    CAST(preceding_visit_detail_id::FLOAT AS BIGINT),
    CAST(visit_detail_parent_id::FLOAT AS BIGINT),
    CAST(visit_occurrence_id::FLOAT AS BIGINT)
FROM
    omopcdm.src_visit_detail;

INSERT INTO
    omopcdm.visit_occurrence (
        visit_occurrence_id,
        person_id,
        visit_concept_id,
        visit_start_date,
        visit_start_datetime,
        visit_end_date,
        visit_end_datetime,
        visit_type_concept_id,
        provider_id,
        care_site_id,
        visit_source_value,
        visit_source_concept_id,
        admitted_from_concept_id,
        admitted_from_source_value,
        discharged_to_concept_id,
        discharged_to_source_value,
        preceding_visit_occurrence_id
    )
SELECT
    CAST(visit_occurrence_id::FLOAT AS BIGINT),
    CAST(person_id::FLOAT AS BIGINT),
    CAST(visit_concept_id::FLOAT AS BIGINT),
    CAST(visit_start_date AS DATE),
    CAST(visit_start_datetime AS TIMESTAMP),
    CAST(visit_end_date AS DATE),
    CAST(visit_end_datetime AS TIMESTAMP),
    CAST(visit_type_concept_id::FLOAT AS BIGINT),
    CAST(provider_id::FLOAT AS BIGINT),
    CAST(care_site_id::FLOAT AS BIGINT),
    CAST(visit_source_value AS TEXT),
    CAST(visit_source_concept_id::FLOAT AS BIGINT),
    CAST(admitting_source_concept_id::FLOAT AS BIGINT),
    CAST(admitting_source_value AS TEXT),
    CAST(discharge_to_concept_id::FLOAT AS BIGINT),
    CAST(discharge_to_source_value AS TEXT),
    CAST(preceding_visit_occurrence_id::FLOAT AS BIGINT)
FROM
    omopcdm.src_visit_occurrence;


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
    'MIMIC-IV' AS cdm_source_name,
    'MIMIC-IV' AS cdm_source_abbreviation,
    'MIT' AS cdm_holder,
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

