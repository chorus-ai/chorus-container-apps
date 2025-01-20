CREATE TABLE omopcdm.src_condition_occurrence
(
    condition_occurrence_id       TEXT,
    person_id                     TEXT,
    condition_concept_id          TEXT,
    condition_start_date          TEXT,
    condition_start_datetime      TEXT,
    condition_end_date            TEXT,
    condition_end_datetime        TEXT,
    condition_type_concept_id     TEXT,
    condition_status_concept_id   TEXT,
    stop_reason                   TEXT,
    provider_id                   TEXT,
    visit_occurrence_id           TEXT,
    visit_detail_id               TEXT,
    condition_source_value        TEXT,
    condition_source_concept_id   TEXT,
    condition_status_source_value TEXT
);

CREATE TABLE omopcdm.src_death
(
    death_cause_id          TEXT,
    person_id               TEXT,
    death_date              TEXT,
    death_datetime          TEXT,
    death_type_concept_id   TEXT,
    cause_concept_id        TEXT,
    cause_source_value      TEXT,
    cause_source_concept_id TEXT
);

CREATE TABLE omopcdm.src_device_exposure
(
    device_exposure_id             TEXT,
    person_id                      TEXT,
    device_concept_id              TEXT,
    device_exposure_start_date     TEXT,
    device_exposure_start_datetime TEXT,
    device_exposure_end_date       TEXT,
    device_exposure_end_datetime   TEXT,
    device_type_concept_id         TEXT,
    unique_device_id               TEXT,
    production_id                  TEXT,
    quantity                       TEXT,
    provider_id                    TEXT,
    visit_occurrence_id            TEXT,
    visit_detail_id                TEXT,
    device_source_value            TEXT,
    device_source_concept_id       TEXT,
    unit_concept_id                TEXT,
    unit_source_value              TEXT,
    unit_source_concept_id         TEXT
)
;

CREATE TABLE omopcdm.src_drug_exposure
(
    drug_exposure_id             TEXT,
    person_id                    TEXT,
    drug_concept_id              TEXT,
    drug_exposure_start_date     TEXT,
    drug_exposure_start_datetime TEXT,
    drug_exposure_end_date       TEXT,
    drug_exposure_end_datetime   TEXT,
    verbatim_end_date            TEXT,
    drug_type_concept_id         TEXT,
    stop_reason                  TEXT,
    refills                      TEXT,
    quantity                     TEXT,
    days_supply                  TEXT,
    sig                          TEXT,
    route_concept_id             TEXT,
    lot_number                   TEXT,
    provider_id                  TEXT,
    visit_occurrence_id          TEXT,
    visit_detail_id              TEXT,
    drug_source_value            TEXT,
    drug_source_concept_id       TEXT,
    route_source_value           TEXT,
    dose_unit_source_value       TEXT
);

CREATE TABLE omopcdm.src_measurement
(
    measurement_id                TEXT,
    person_id                     TEXT,
    measurement_concept_id        TEXT,
    measurement_date              TEXT,
    measurement_datetime          TEXT,
    measurement_time              TEXT,
    measurement_type_concept_id   TEXT,
    operator_concept_id           TEXT,
    value_as_number               TEXT,
    value_as_concept_id           TEXT,
    unit_concept_id               TEXT,
    range_low                     TEXT,
    range_high                    TEXT,
    provider_id                   TEXT,
    visit_occurrence_id           TEXT,
    visit_detail_id               TEXT,
    measurement_source_value      TEXT,
    measurement_source_concept_id TEXT,
    unit_source_value             TEXT,
    unit_source_concept_id        TEXT,
    value_source_value            TEXT,
    measurement_event_id          TEXT,
    meas_event_field_concept_id   TEXT
);


CREATE TABLE omopcdm.src_observation
(
    observation_id                TEXT,
    person_id                     TEXT,
    observation_concept_id        TEXT,
    observation_date              TEXT,
    observation_datetime          TEXT,
    observation_type_concept_id   TEXT,
    value_as_number               TEXT,
    value_as_string               TEXT,
    value_as_concept_id           TEXT,
    qualifier_concept_id          TEXT,
    unit_concept_id               TEXT,
    provider_id                   TEXT,
    visit_occurrence_id           TEXT,
    visit_detail_id               TEXT,
    observation_source_value      TEXT,
    observation_source_concept_id TEXT,
    unit_source_value             TEXT,
    qualifier_source_value        TEXT,
    value_source_value            TEXT,
    observation_event_id          TEXT,
    obs_event_field_concept_id    TEXT
);

CREATE TABLE omopcdm.src_observation_period
(
    observation_period_id         TEXT,
    person_id                     TEXT,
    observation_period_start_date TEXT,
    observation_period_end_date   TEXT,
    period_type_concept_id        TEXT
);

CREATE TABLE omopcdm.src_person
(
    person_id                   TEXT,
    gender_concept_id           TEXT,
    year_of_birth               TEXT,
    month_of_birth              TEXT,
    day_of_birth                TEXT,
    birth_datetime              TEXT,
    race_concept_id             TEXT,
    ethnicity_concept_id        TEXT,
    location_id                 TEXT,
    provider_id                 TEXT,
    care_site_id                TEXT,
    person_source_value         TEXT,
    gender_source_value         TEXT,
    gender_source_concept_id    TEXT,
    race_source_value           TEXT,
    race_source_concept_id      TEXT,
    ethnicity_source_value      TEXT,
    ethnicity_source_concept_id TEXT
);

CREATE TABLE omopcdm.src_procedure_occurrence
(
    procedure_occurrence_id     TEXT,
    person_id                   TEXT,
    procedure_concept_id        TEXT,
    procedure_date              TEXT,
    procedure_datetime          TEXT,
    procedure_end_date          TEXT,
    procedure_end_datetime      TEXT,
    procedure_type_concept_id   TEXT,
    modifier_concept_id         TEXT,
    quantity                    TEXT,
    provider_id                 TEXT,
    visit_occurrence_id         TEXT,
    visit_detail_id             TEXT,
    procedure_source_value      TEXT,
    procedure_source_concept_id TEXT,
    modifier_source_value       TEXT
);

CREATE TABLE omopcdm.src_visit_occurrence
(
    visit_occurrence_id           TEXT,
    person_id                     TEXT,
    visit_concept_id              TEXT,
    visit_start_date              TEXT,
    visit_start_datetime          TEXT,
    visit_end_date                TEXT,
    visit_end_datetime            TEXT,
    visit_type_concept_id         TEXT,
    provider_id                   TEXT,
    care_site_id                  TEXT,
    visit_source_value            TEXT,
    visit_source_concept_id       TEXT,
    admitted_from_concept_id      TEXT,
    admitted_from_source_value    TEXT,
    discharged_to_concept_id      TEXT,
    discharged_to_source_value    TEXT,
    preceding_visit_occurrence_id TEXT
);


CREATE TABLE omopcdm.src_visit_detail
(
    visit_detail_id                TEXT,
    person_id                      TEXT,
    visit_detail_concept_id        TEXT,
    visit_detail_start_date        TEXT,
    visit_detail_start_datetime    TEXT,
    visit_detail_end_date          TEXT,
    visit_detail_end_datetime      TEXT,
    visit_detail_type_concept_id   TEXT,
    provider_id                    TEXT,
    care_site_id                   TEXT,
    visit_detail_source_value      TEXT,
    visit_detail_source_concept_id TEXT,
    admitted_from_concept_id       TEXT,
    admitted_from_source_value     TEXT,
    discharged_to_source_value     TEXT,
    discharged_to_concept_id       TEXT,
    preceding_visit_detail_id      TEXT,
    parent_visit_detail_id         TEXT,
    visit_occurrence_id            TEXT
);

CREATE TABLE omopcdm.src_note_nlp
(
    note_nlp_id                TEXT,
    note_id                    TEXT,
    section_concept_id         TEXT,
    snippet                    TEXT,
    "offset"                   TEXT,
    lexical_variant            TEXT,
    note_nlp_concept_id        TEXT,
    note_nlp_source_concept_id TEXT,
    nlp_system                 TEXT,
    nlp_date                   TEXT,
    nlp_datetime               TEXT,
    term_exists                TEXT,
    term_temporal              TEXT,
    term_modifiers             TEXT
);

CREATE TABLE omopcdm.src_note
(
    note_id                     TEXT,
    person_id                   TEXT,
    note_date                   TEXT,
    note_datetime               TEXT,
    note_type_concept_id        TEXT,
    note_class_concept_id       TEXT,
    note_title                  TEXT,
    note_text                   TEXT,
    encoding_concept_id         TEXT,
    language_concept_id         TEXT,
    provider_id                 TEXT,
    visit_occurrence_id         TEXT,
    visit_detail_id             TEXT,
    note_source_value           TEXT,
    note_event_id               TEXT,
    note_event_field_concept_id TEXT
);

