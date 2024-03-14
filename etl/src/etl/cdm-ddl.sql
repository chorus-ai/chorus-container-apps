CREATE TABLE person (
  person_id integer NOT NULL,
  gender_concept_id integer NOT NULL,
  year_of_birth integer NOT NULL,
  month_of_birth integer,
  day_of_birth integer,
  birth_datetime timestamp,
  race_concept_id integer NOT NULL,
  ethnicity_concept_id integer NOT NULL,
  location_id integer,
  provider_id integer,
  care_site_id integer,
  person_source_value text,
  gender_source_value text,
  gender_source_concept_id integer,
  race_source_value text,
  race_source_concept_id integer,
  ethnicity_source_value text,
  ethnicity_source_concept_id integer
);

CREATE TABLE observation_period (
  observation_period_id integer NOT NULL,
  person_id integer NOT NULL,
  observation_period_start_date date NOT NULL,
  observation_period_end_date date NOT NULL,
  period_type_concept_id integer NOT NULL
);

CREATE TABLE visit_occurrence (
  visit_occurrence_id integer NOT NULL,
  person_id integer NOT NULL,
  visit_concept_id integer NOT NULL,
  visit_start_date date NOT NULL,
  visit_start_datetime timestamp,
  visit_end_date date NOT NULL,
  visit_end_datetime timestamp,
  visit_type_concept_id integer NOT NULL,
  provider_id integer,
  care_site_id integer,
  visit_source_value text,
  visit_source_concept_id integer,
  admitted_from_concept_id integer,
  admitted_from_source_value text,
  discharged_to_concept_id integer,
  discharged_to_source_value text,
  preceding_visit_occurrence_id integer
);

CREATE TABLE visit_detail (
  visit_detail_id integer NOT NULL,
  person_id integer NOT NULL,
  visit_detail_concept_id integer NOT NULL,
  visit_detail_start_date date NOT NULL,
  visit_detail_start_datetime timestamp,
  visit_detail_end_date date NOT NULL,
  visit_detail_end_datetime timestamp,
  visit_detail_type_concept_id integer NOT NULL,
  provider_id integer,
  care_site_id integer,
  visit_detail_source_value text,
  visit_detail_source_concept_id Integer,
  admitted_from_concept_id integer,
  admitted_from_source_value text,
  discharged_to_concept_id integer,
  discharged_to_source_value text,
  preceding_visit_detail_id integer,
  parent_visit_detail_id integer,
  visit_occurrence_id integer NOT NULL
);

CREATE TABLE condition_occurrence (
  condition_occurrence_id integer NOT NULL,
  person_id integer NOT NULL,
  condition_concept_id integer NOT NULL,
  condition_start_date date NOT NULL,
  condition_start_datetime timestamp,
  condition_end_date date,
  condition_end_datetime timestamp,
  condition_type_concept_id integer NOT NULL,
  condition_status_concept_id integer,
  stop_reason text,
  provider_id integer,
  visit_occurrence_id integer,
  visit_detail_id integer,
  condition_source_value text,
  condition_source_concept_id integer,
  condition_status_source_value text
);

CREATE TABLE drug_exposure (
  drug_exposure_id integer NOT NULL,
  person_id integer NOT NULL,
  drug_concept_id integer NOT NULL,
  drug_exposure_start_date date NOT NULL,
  drug_exposure_start_datetime timestamp,
  drug_exposure_end_date date NOT NULL,
  drug_exposure_end_datetime timestamp,
  verbatim_end_date date,
  drug_type_concept_id integer NOT NULL,
  stop_reason text,
  refills integer,
  quantity float,
  days_supply integer,
  sig text,
  route_concept_id integer,
  lot_number text,
  provider_id integer,
  visit_occurrence_id integer,
  visit_detail_id integer,
  drug_source_value text,
  drug_source_concept_id integer,
  route_source_value text,
  dose_unit_source_value text
);

CREATE TABLE procedure_occurrence (
  procedure_occurrence_id integer NOT NULL,
  person_id integer NOT NULL,
  procedure_concept_id integer NOT NULL,
  procedure_date date NOT NULL,
  procedure_datetime timestamp,
  procedure_end_date date,
  procedure_end_datetime timestamp,
  procedure_type_concept_id integer NOT NULL,
  modifier_concept_id integer,
  quantity integer,
  provider_id integer,
  visit_occurrence_id integer,
  visit_detail_id integer,
  procedure_source_value text,
  procedure_source_concept_id integer,
  modifier_source_value text
);

CREATE TABLE device_exposure (
  device_exposure_id integer NOT NULL,
  person_id integer NOT NULL,
  device_concept_id integer NOT NULL,
  device_exposure_start_date date NOT NULL,
  device_exposure_start_datetime timestamp,
  device_exposure_end_date date,
  device_exposure_end_datetime timestamp,
  device_type_concept_id integer NOT NULL,
  unique_device_id text,
  production_id text,
  quantity integer,
  provider_id integer,
  visit_occurrence_id integer,
  visit_detail_id integer,
  device_source_value text,
  device_source_concept_id integer,
  unit_concept_id integer,
  unit_source_value text,
  unit_source_concept_id integer
);

CREATE TABLE measurement (
  measurement_id integer NOT NULL,
  person_id integer NOT NULL,
  measurement_concept_id integer NOT NULL,
  measurement_date date NOT NULL,
  measurement_datetime timestamp,
  measurement_time text,
  measurement_type_concept_id integer NOT NULL,
  operator_concept_id integer,
  value_as_number float,
  value_as_concept_id integer,
  unit_concept_id integer,
  range_low float,
  range_high float,
  provider_id integer,
  visit_occurrence_id integer,
  visit_detail_id integer,
  measurement_source_value text,
  measurement_source_concept_id integer,
  unit_source_value text,
  unit_source_concept_id integer,
  value_source_value text,
  measurement_event_id integer,
  meas_event_field_concept_id integer
);

CREATE TABLE observation (
  observation_id integer NOT NULL,
  person_id integer NOT NULL,
  observation_concept_id integer NOT NULL,
  observation_date date NOT NULL,
  observation_datetime timestamp,
  observation_type_concept_id integer NOT NULL,
  value_as_number float,
  value_as_string text,
  value_as_concept_id integer,
  qualifier_concept_id integer,
  unit_concept_id integer,
  provider_id integer,
  visit_occurrence_id integer,
  visit_detail_id integer,
  observation_source_value text,
  observation_source_concept_id integer,
  unit_source_value text,
  qualifier_source_value text,
  value_source_value text,
  observation_event_id integer,
  obs_event_field_concept_id integer
);

CREATE TABLE death (
  person_id integer NOT NULL,
  death_date date NOT NULL,
  death_datetime timestamp,
  death_type_concept_id integer,
  cause_concept_id integer,
  cause_source_value text,
  cause_source_concept_id integer
);

CREATE TABLE note (
  note_id integer NOT NULL,
  person_id integer NOT NULL,
  note_date date NOT NULL,
  note_datetime timestamp,
  note_type_concept_id integer NOT NULL,
  note_class_concept_id integer NOT NULL,
  note_title text,
  note_text text NOT NULL,
  encoding_concept_id integer NOT NULL,
  language_concept_id integer NOT NULL,
  provider_id integer,
  visit_occurrence_id integer,
  visit_detail_id integer,
  note_source_value text,
  note_event_id integer,
  note_event_field_concept_id integer
);

CREATE TABLE note_nlp (
  note_nlp_id integer NOT NULL,
  note_id integer NOT NULL,
  section_concept_id integer,
  snippet text,
  "offset" text,
  lexical_variant text NOT NULL,
  note_nlp_concept_id integer,
  note_nlp_source_concept_id integer,
  nlp_system text,
  nlp_date date NOT NULL,
  nlp_datetime timestamp,
  term_exists text,
  term_temporal text,
  term_modifiers text
);

CREATE TABLE specimen (
  specimen_id integer NOT NULL,
  person_id integer NOT NULL,
  specimen_concept_id integer NOT NULL,
  specimen_type_concept_id integer NOT NULL,
  specimen_date date NOT NULL,
  specimen_datetime timestamp,
  quantity float,
  unit_concept_id integer,
  anatomic_site_concept_id integer,
  disease_status_concept_id integer,
  specimen_source_id text,
  specimen_source_value text,
  unit_source_value text,
  anatomic_site_source_value text,
  disease_status_source_value text
);

CREATE TABLE fact_relationship (
  domain_concept_id_1 integer NOT NULL,
  fact_id_1 integer NOT NULL,
  domain_concept_id_2 integer NOT NULL,
  fact_id_2 integer NOT NULL,
  relationship_concept_id integer NOT NULL
);

CREATE TABLE location (
  location_id integer NOT NULL,
  address_1 text,
  address_2 text,
  city text,
  state text,
  zip text,
  county text,
  location_source_value text,
  country_concept_id integer,
  country_source_value text,
  latitude float,
  longitude float
);

CREATE TABLE care_site (
  care_site_id integer NOT NULL,
  care_site_name text,
  place_of_service_concept_id integer,
  location_id integer,
  care_site_source_value text,
  place_of_service_source_value text
);

CREATE TABLE provider (
  provider_id integer NOT NULL,
  provider_name text,
  npi text,
  dea text,
  specialty_concept_id integer,
  care_site_id integer,
  year_of_birth integer,
  gender_concept_id integer,
  provider_source_value text,
  specialty_source_value text,
  specialty_source_concept_id integer,
  gender_source_value text,
  gender_source_concept_id integer
);

CREATE TABLE payer_plan_period (
  payer_plan_period_id integer NOT NULL,
  person_id integer NOT NULL,
  payer_plan_period_start_date date NOT NULL,
  payer_plan_period_end_date date NOT NULL,
  payer_concept_id integer,
  payer_source_value text,
  payer_source_concept_id integer,
  plan_concept_id integer,
  plan_source_value text,
  plan_source_concept_id integer,
  sponsor_concept_id integer,
  sponsor_source_value text,
  sponsor_source_concept_id integer,
  family_source_value text,
  stop_reason_concept_id integer,
  stop_reason_source_value text,
  stop_reason_source_concept_id integer
);

CREATE TABLE cost (
  cost_id integer NOT NULL,
  cost_event_id integer NOT NULL,
  cost_domain_id text NOT NULL,
  cost_type_concept_id integer NOT NULL,
  currency_concept_id integer,
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
  payer_plan_period_id integer,
  amount_allowed float,
  revenue_code_concept_id integer,
  revenue_code_source_value text,
  drg_concept_id integer,
  drg_source_value text
);

CREATE TABLE drug_era (
  drug_era_id integer NOT NULL,
  person_id integer NOT NULL,
  drug_concept_id integer NOT NULL,
  drug_era_start_date date NOT NULL,
  drug_era_end_date date NOT NULL,
  drug_exposure_count integer,
  gap_days integer
);

CREATE TABLE dose_era (
  dose_era_id integer NOT NULL,
  person_id integer NOT NULL,
  drug_concept_id integer NOT NULL,
  unit_concept_id integer NOT NULL,
  dose_value float NOT NULL,
  dose_era_start_date date NOT NULL,
  dose_era_end_date date NOT NULL
);

CREATE TABLE condition_era (
  condition_era_id integer NOT NULL,
  person_id integer NOT NULL,
  condition_concept_id integer NOT NULL,
  condition_era_start_date date NOT NULL,
  condition_era_end_date date NOT NULL,
  condition_occurrence_count integer
);

CREATE TABLE episode (
  episode_id integer NOT NULL,
  person_id integer NOT NULL,
  episode_concept_id integer NOT NULL,
  episode_start_date date NOT NULL,
  episode_start_datetime timestamp,
  episode_end_date date,
  episode_end_datetime timestamp,
  episode_parent_id integer,
  episode_number integer,
  episode_object_concept_id integer NOT NULL,
  episode_type_concept_id integer NOT NULL,
  episode_source_value text,
  episode_source_concept_id integer
);

CREATE TABLE episode_event (
  episode_id integer NOT NULL,
  event_id integer NOT NULL,
  episode_event_field_concept_id integer NOT NULL
);

CREATE TABLE metadata (
  metadata_id integer NOT NULL,
  metadata_concept_id integer NOT NULL,
  metadata_type_concept_id integer NOT NULL,
  name text NOT NULL,
  value_as_string text,
  value_as_concept_id integer,
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
  cdm_version_concept_id integer NOT NULL,
  vocabulary_version text NOT NULL
);

CREATE TABLE cohort (
  cohort_definition_id integer NOT NULL,
  subject_id integer NOT NULL,
  cohort_start_date date NOT NULL,
  cohort_end_date date NOT NULL
);

CREATE TABLE cohort_definition (
  cohort_definition_id integer NOT NULL,
  cohort_definition_name text NOT NULL,
  cohort_definition_description text,
  definition_type_concept_id integer NOT NULL,
  cohort_definition_syntax text,
  subject_concept_id integer NOT NULL,
  cohort_initiation_date date
);
