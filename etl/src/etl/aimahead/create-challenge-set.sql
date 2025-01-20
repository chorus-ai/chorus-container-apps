CREATE VIEW aimahead.concept AS SELECT * FROM vocabulary.concept;

CREATE VIEW aimahead.concept_relationship AS SELECT * FROM vocabulary.concept_relationship;

CREATE VIEW aimahead.concept_ancestor AS SELECT * FROM vocabulary.concept_ancestor;

CREATE VIEW aimahead.concept_class AS SELECT * FROM vocabulary.concept_class;

CREATE VIEW aimahead.concept_recommended AS SELECT * FROM vocabulary.concept_recommended;

CREATE VIEW aimahead.concept_synonym AS SELECT * FROM vocabulary.concept_synonym;

CREATE VIEW aimahead.domain AS SELECT * FROM vocabulary.domain;

CREATE VIEW aimahead.drug_strength AS SELECT * FROM vocabulary.drug_strength;

CREATE VIEW aimahead.relationship AS SELECT * FROM vocabulary.relationship;

CREATE VIEW aimahead.source_to_concept_map AS SELECT * FROM vocabulary.source_to_concept_map;

CREATE VIEW aimahead.vocabulary AS SELECT * FROM vocabulary.vocabulary;

-- CDM TABLES

CREATE VIEW aimahead.care_site AS SELECT * FROM omopcdm.care_site;

CREATE VIEW aimahead.condition_era AS SELECT * FROM omopcdm.condition_era;

CREATE VIEW aimahead.condition_occurrence AS SELECT * FROM omopcdm.condition_occurrence;

CREATE VIEW aimahead.cost AS SELECT * FROM omopcdm.cost;

CREATE VIEW aimahead.death AS SELECT * FROM omopcdm.death;

CREATE VIEW aimahead.device_exposure AS SELECT * FROM omopcdm.device_exposure;

CREATE VIEW aimahead.dose_era AS SELECT * FROM omopcdm.dose_era;

CREATE VIEW aimahead.drug_era AS SELECT * FROM omopcdm.drug_era;

CREATE VIEW aimahead.drug_exposure AS SELECT * FROM omopcdm.drug_exposure;

CREATE VIEW aimahead.episode AS SELECT * FROM omopcdm.episode;

CREATE VIEW aimahead.episode_event AS SELECT * FROM omopcdm.episode_event;

CREATE VIEW aimahead.fact_relationship AS SELECT * FROM omopcdm.fact_relationship;

CREATE VIEW aimahead.location AS SELECT * FROM omopcdm.location;

CREATE VIEW aimahead.condition_occurrence AS SELECT * FROM omopcdm.location_history;

CREATE VIEW aimahead.measurement AS SELECT * FROM omopcdm.measurement;

CREATE VIEW aimahead.metadata AS SELECT * FROM omopcdm.metadata;

CREATE VIEW aimahead.note AS SELECT * FROM omopcdm.note;

CREATE VIEW aimahead.note_nlp AS SELECT * FROM omopcdm.note_nlp;

CREATE VIEW aimahead.observation AS SELECT * FROM omopcdm.observation;

CREATE VIEW aimahead.observation_period AS SELECT * FROM omopcdm.observation_period;

CREATE VIEW aimahead.payer_plan_period AS SELECT * FROM omopcdm.payer_plan_period;

CREATE VIEW aimahead.person AS SELECT * FROM omopcdm.person;

CREATE VIEW aimahead.procedure_occurrence AS SELECT * FROM omopcdm.procedure_occurrence;

CREATE VIEW aimahead.provider AS SELECT * FROM omopcdm.provider;

CREATE VIEW aimahead.specimen AS SELECT * FROM omopcdm.specimen;

CREATE VIEW aimahead.visit_detail AS SELECT * FROM omopcdm.visit_detail;

CREATE VIEW aimahead.visit_occurrence AS SELECT * FROM omopcdm.visit_occurrence;

CREATE VIEW aimahead.cohort AS SELECT * FROM omopcdm.cohort;

CREATE VIEW aimahead.cohort_definition AS SELECT * FROM omopcdm.cohort_definition;

CREATE TABLE aimahead.cdm_source (
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

INSERT INTO
    aimahead.cdm_source (
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
    'AIMAHEAD - RAW' AS cdm_source_name,
    'AIMAHEAD - RAW' AS cdm_source_abbreviation,
    'CHoRUS' AS cdm_holder,
    NULL AS source_description,
    NULL AS source_documentation_reference,
    'https://github.com/chorus-ai/chorus-container-apps' AS cdm_etl_reference,
    CURRENT_DATE AS source_release_date,
    CURRENT_DATE AS cdm_release_date,
    'v5.4.0' AS cdm_version,
    756265
    /* OMOP CDM Version 5.4.0 */
    AS cdm_version_concept_id,
    (SELECT vocabulary_version FROM vocabulary.vocabulary WHERE vocabulary_id = 'None') AS vocabulary_version;