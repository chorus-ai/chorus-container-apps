CREATE TABLE person (
  person_id bigint NOT NULL,
  gender_concept_id bigint NOT NULL,
  year_of_birth bigint NOT NULL,
  month_of_birth bigint,
  day_of_birth bigint,
  birth_datetime timestamp,
  race_concept_id bigint NOT NULL,
  ethnicity_concept_id bigint NOT NULL,
  location_id bigint,
  provider_id bigint,
  care_site_id bigint,
  person_source_value text,
  gender_source_value text,
  gender_source_concept_id bigint,
  race_source_value text,
  race_source_concept_id bigint,
  ethnicity_source_value text,
  ethnicity_source_concept_id bigint,
  src_person_id bigint,
  src_name varchar(50)
);

CREATE TABLE observation_period (
  observation_period_id bigint NOT NULL,
  person_id bigint NOT NULL,
  observation_period_start_date date NOT NULL,
  observation_period_end_date date NOT NULL,
  period_type_concept_id bigint NOT NULL
);

CREATE TABLE visit_occurrence (
  visit_occurrence_id bigint NOT NULL,
  person_id bigint NOT NULL,
  visit_concept_id bigint NOT NULL,
  visit_start_date date NOT NULL,
  visit_start_datetime timestamp,
  visit_end_date date NOT NULL,
  visit_end_datetime timestamp,
  visit_type_concept_id bigint NOT NULL,
  provider_id bigint,
  care_site_id bigint,
  visit_source_value text,
  visit_source_concept_id bigint,
  admitted_from_concept_id bigint,
  admitted_from_source_value text,
  discharged_to_concept_id bigint,
  discharged_to_source_value text,
  preceding_visit_occurrence_id bigint,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_prec_visit_occurrence_id bigint,
  src_name varchar(50)
);

CREATE TABLE visit_detail (
  visit_detail_id bigint NOT NULL,
  person_id bigint NOT NULL,
  visit_detail_concept_id bigint NOT NULL,
  visit_detail_start_date date NOT NULL,
  visit_detail_start_datetime timestamp,
  visit_detail_end_date date NOT NULL,
  visit_detail_end_datetime timestamp,
  visit_detail_type_concept_id bigint NOT NULL,
  provider_id bigint,
  care_site_id bigint,
  visit_detail_source_value text,
  visit_detail_source_concept_id bigint,
  admitted_from_concept_id bigint,
  admitted_from_source_value text,
  discharged_to_concept_id bigint,
  discharged_to_source_value text,
  preceding_visit_detail_id bigint,
  parent_visit_detail_id bigint,
  visit_occurrence_id bigint NOT NULL,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_visit_detail_id bigint,
  src_prec_visit_detail_id bigint,
  src_parent_visit_detail_id bigint,
  src_name varchar(50)
);

CREATE TABLE condition_occurrence (
  condition_occurrence_id bigint NOT NULL,
  person_id bigint NOT NULL,
  condition_concept_id bigint NOT NULL,
  condition_start_date date NOT NULL,
  condition_start_datetime timestamp,
  condition_end_date date,
  condition_end_datetime timestamp,
  condition_type_concept_id bigint NOT NULL,
  condition_status_concept_id bigint,
  stop_reason text,
  provider_id bigint,
  visit_occurrence_id bigint,
  visit_detail_id bigint,
  condition_source_value text,
  condition_source_concept_id bigint,
  condition_status_source_value text,
  src_table_id bigint,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_visit_detail_id bigint,
  src_name varchar(50)
);

CREATE TABLE drug_exposure (
  drug_exposure_id bigint NOT NULL,
  person_id bigint NOT NULL,
  drug_concept_id bigint NOT NULL,
  drug_exposure_start_date date NOT NULL,
  drug_exposure_start_datetime timestamp,
  drug_exposure_end_date date NOT NULL,
  drug_exposure_end_datetime timestamp,
  verbatim_end_date date,
  drug_type_concept_id bigint NOT NULL,
  stop_reason text,
  refills bigint,
  quantity float,
  days_supply bigint,
  sig text,
  route_concept_id bigint,
  lot_number text,
  provider_id bigint,
  visit_occurrence_id bigint,
  visit_detail_id bigint,
  drug_source_value text,
  drug_source_concept_id bigint,
  route_source_value text,
  dose_unit_source_value text,
  src_table_id bigint,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_visit_detail_id bigint,
  src_name varchar(50)
);

CREATE TABLE procedure_occurrence (
  procedure_occurrence_id bigint NOT NULL,
  person_id bigint NOT NULL,
  procedure_concept_id bigint NOT NULL,
  procedure_date date NOT NULL,
  procedure_datetime timestamp,
  procedure_end_date date,
  procedure_end_datetime timestamp,
  procedure_type_concept_id bigint NOT NULL,
  modifier_concept_id bigint,
  quantity bigint,
  provider_id bigint,
  visit_occurrence_id bigint,
  visit_detail_id bigint,
  procedure_source_value text,
  procedure_source_concept_id bigint,
  modifier_source_value text,
  src_table_id bigint,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_visit_detail_id bigint,
  src_name varchar(50)
);

CREATE TABLE device_exposure (
  device_exposure_id bigint NOT NULL,
  person_id bigint NOT NULL,
  device_concept_id bigint NOT NULL,
  device_exposure_start_date date NOT NULL,
  device_exposure_start_datetime timestamp,
  device_exposure_end_date date,
  device_exposure_end_datetime timestamp,
  device_type_concept_id bigint NOT NULL,
  unique_device_id text,
  production_id text,
  quantity bigint,
  provider_id bigint,
  visit_occurrence_id bigint,
  visit_detail_id bigint,
  device_source_value text,
  device_source_concept_id bigint,
  unit_concept_id bigint,
  unit_source_value text,
  unit_source_concept_id bigint,
  src_table_id bigint,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_visit_detail_id bigint,
  src_name varchar(50)
);

CREATE TABLE measurement (
  measurement_id bigint NOT NULL,
  person_id bigint NOT NULL,
  measurement_concept_id bigint NOT NULL,
  measurement_date date NOT NULL,
  measurement_datetime timestamp,
  measurement_time text,
  measurement_type_concept_id bigint NOT NULL,
  operator_concept_id bigint,
  value_as_number float,
  value_as_concept_id bigint,
  unit_concept_id bigint,
  range_low float,
  range_high float,
  provider_id bigint,
  visit_occurrence_id bigint,
  visit_detail_id bigint,
  measurement_source_value text,
  measurement_source_concept_id bigint,
  unit_source_value text,
  unit_source_concept_id bigint,
  value_source_value text,
  measurement_event_id bigint,
  meas_event_field_concept_id bigint,
  src_table_id bigint,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_visit_detail_id bigint,
  src_name varchar(50)
);

CREATE TABLE observation (
  observation_id bigint NOT NULL,
  person_id bigint NOT NULL,
  observation_concept_id bigint NOT NULL,
  observation_date date NOT NULL,
  observation_datetime timestamp,
  observation_type_concept_id bigint NOT NULL,
  value_as_number float,
  value_as_string text,
  value_as_concept_id bigint,
  qualifier_concept_id bigint,
  unit_concept_id bigint,
  provider_id bigint,
  visit_occurrence_id bigint,
  visit_detail_id bigint,
  observation_source_value text,
  observation_source_concept_id bigint,
  unit_source_value text,
  qualifier_source_value text,
  value_source_value text,
  observation_event_id bigint,
  obs_event_field_concept_id bigint,
  src_table_id bigint,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_visit_detail_id bigint,
  src_name varchar(50)
);

CREATE TABLE death (
  person_id bigint NOT NULL,
  death_date date NOT NULL,
  death_datetime timestamp,
  death_type_concept_id bigint,
  cause_concept_id bigint,
  cause_source_value text,
  cause_source_concept_id bigint,
  src_person_id bigint,
  src_name varchar(50)
);

CREATE TABLE note (
  note_id bigint NOT NULL,
  person_id bigint NOT NULL,
  note_date date NOT NULL,
  note_datetime timestamp,
  note_type_concept_id bigint NOT NULL,
  note_class_concept_id bigint NOT NULL,
  note_title text,
  note_text text NOT NULL,
  encoding_concept_id bigint NOT NULL,
  language_concept_id bigint NOT NULL,
  provider_id bigint,
  visit_occurrence_id bigint,
  visit_detail_id bigint,
  note_source_value text,
  note_event_id bigint,
  note_event_field_concept_id bigint,
  src_table_id bigint,
  src_person_id bigint,
  src_visit_occurrence_id bigint,
  src_visit_detail_id bigint,
  src_name varchar(50)
);

CREATE TABLE note_nlp (
  note_nlp_id bigint NOT NULL,
  note_id bigint NOT NULL,
  section_concept_id bigint,
  snippet text,
  "offset" text,
  lexical_variant text NOT NULL,
  note_nlp_concept_id bigint,
  note_nlp_source_concept_id bigint,
  nlp_system text,
  nlp_date date NOT NULL,
  nlp_datetime timestamp,
  term_exists text,
  term_temporal text,
  term_modifiers text,
  src_table_id bigint,
  src_note_id bigint,
  src_name varchar(50)
);

CREATE TABLE specimen (
  specimen_id bigint NOT NULL,
  person_id bigint NOT NULL,
  specimen_concept_id bigint NOT NULL,
  specimen_type_concept_id bigint NOT NULL,
  specimen_date date NOT NULL,
  specimen_datetime timestamp,
  quantity float,
  unit_concept_id bigint,
  anatomic_site_concept_id bigint,
  disease_status_concept_id bigint,
  specimen_source_id text,
  specimen_source_value text,
  unit_source_value text,
  anatomic_site_source_value text,
  disease_status_source_value text,
  src_table_id bigint,
  src_person_id bigint,
  src_name varchar(50)
);

CREATE TABLE fact_relationship (
  domain_concept_id_1 bigint NOT NULL,
  fact_id_1 bigint NOT NULL,
  domain_concept_id_2 bigint NOT NULL,
  fact_id_2 bigint NOT NULL,
  relationship_concept_id bigint NOT NULL
);

CREATE TABLE location (
  location_id bigint NOT NULL,
  address_1 text,
  address_2 text,
  city text,
  state text,
  zip text,
  county text,
  location_source_value text,
  country_concept_id bigint,
  country_source_value text,
  latitude float,
  longitude float
);

CREATE TABLE care_site (
  care_site_id bigint NOT NULL,
  care_site_name text,
  place_of_service_concept_id bigint,
  location_id bigint,
  care_site_source_value text,
  place_of_service_source_value text
);

CREATE TABLE provider (
  provider_id bigint NOT NULL,
  provider_name text,
  npi text,
  dea text,
  specialty_concept_id bigint,
  care_site_id bigint,
  year_of_birth bigint,
  gender_concept_id bigint,
  provider_source_value text,
  specialty_source_value text,
  specialty_source_concept_id bigint,
  gender_source_value text,
  gender_source_concept_id bigint
);

CREATE TABLE payer_plan_period (
  payer_plan_period_id bigint NOT NULL,
  person_id bigint NOT NULL,
  payer_plan_period_start_date date NOT NULL,
  payer_plan_period_end_date date NOT NULL,
  payer_concept_id bigint,
  payer_source_value text,
  payer_source_concept_id bigint,
  plan_concept_id bigint,
  plan_source_value text,
  plan_source_concept_id bigint,
  sponsor_concept_id bigint,
  sponsor_source_value text,
  sponsor_source_concept_id bigint,
  family_source_value text,
  stop_reason_concept_id bigint,
  stop_reason_source_value text,
  stop_reason_source_concept_id bigint
);

CREATE TABLE cost (
  cost_id bigint NOT NULL,
  cost_event_id bigint NOT NULL,
  cost_domain_id text NOT NULL,
  cost_type_concept_id bigint NOT NULL,
  currency_concept_id bigint,
  total_charge float,
  total_cost float,
  total_paid float,
  paid_by_payer float,
  paid_by_patient float,
  paid_patient_copay float,
  paid_patient_coinsurance float,
  paid_patient_deductible float,
  paid_by_primary float,
  paid_ingredient_cost float,
  paid_dispensing_fee float,
  payer_plan_period_id bigint,
  amount_allowed float,
  revenue_code_concept_id bigint,
  revenue_code_source_value text,
  drg_concept_id bigint,
  drg_source_value text
);

CREATE TABLE drug_era (
  drug_era_id bigint NOT NULL,
  person_id bigint NOT NULL,
  drug_concept_id bigint NOT NULL,
  drug_era_start_date date NOT NULL,
  drug_era_end_date date NOT NULL,
  drug_exposure_count bigint,
  gap_days bigint
);

CREATE TABLE dose_era (
  dose_era_id bigint NOT NULL,
  person_id bigint NOT NULL,
  drug_concept_id bigint NOT NULL,
  unit_concept_id bigint NOT NULL,
  dose_value float NOT NULL,
  dose_era_start_date date NOT NULL,
  dose_era_end_date date NOT NULL
);

CREATE TABLE condition_era (
  condition_era_id bigint NOT NULL,
  person_id bigint NOT NULL,
  condition_concept_id bigint NOT NULL,
  condition_era_start_date date NOT NULL,
  condition_era_end_date date NOT NULL,
  condition_occurrence_count bigint
);

CREATE TABLE episode (
  episode_id bigint NOT NULL,
  person_id bigint NOT NULL,
  episode_concept_id bigint NOT NULL,
  episode_start_date date NOT NULL,
  episode_start_datetime timestamp,
  episode_end_date date,
  episode_end_datetime timestamp,
  episode_parent_id bigint,
  episode_number bigint,
  episode_object_concept_id bigint NOT NULL,
  episode_type_concept_id bigint NOT NULL,
  episode_source_value text,
  episode_source_concept_id bigint
);

CREATE TABLE episode_event (
  episode_id bigint NOT NULL,
  event_id bigint NOT NULL,
  episode_event_field_concept_id bigint NOT NULL
);

CREATE TABLE metadata (
  metadata_id bigint NOT NULL,
  metadata_concept_id bigint NOT NULL,
  metadata_type_concept_id bigint NOT NULL,
  name text NOT NULL,
  value_as_text text,
  value_as_concept_id bigint,
  value_as_number float,
  metadata_date date,
  metadata_datetime timestamp
);

CREATE TABLE cdm_source (
  cdm_source_name text NOT NULL,
  cdm_source_abbreviation text NOT NULL,
  cdm_holder text NOT NULL,
  source_description text,
  source_documentation_reference text,
  cdm_etl_reference text,
  source_release_date date NOT NULL,
  cdm_release_date date NOT NULL,
  cdm_version text,
  cdm_version_concept_id bigint NOT NULL,
  vocabulary_version text NOT NULL
);

CREATE TABLE cohort (
  cohort_definition_id bigint NOT NULL,
  subject_id bigint NOT NULL,
  cohort_start_date date NOT NULL,
  cohort_end_date date NOT NULL
);

CREATE TABLE cohort_definition (
  cohort_definition_id bigint NOT NULL,
  cohort_definition_name text NOT NULL,
  cohort_definition_description text,
  definition_type_concept_id bigint NOT NULL,
  cohort_definition_syntax text,
  subject_concept_id bigint NOT NULL,
  cohort_initiation_date date
);
