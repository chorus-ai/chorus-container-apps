CREATE INDEX idx_person_id ON omopcdm.person (person_id ASC);
CLUSTER omopcdm.person USING idx_person_id;
CREATE INDEX idx_gender ON omopcdm.person (gender_concept_id ASC);

CREATE INDEX idx_visit_person_id_1 ON omopcdm.visit_occurrence (person_id ASC);
CLUSTER omopcdm.visit_occurrence USING idx_visit_person_id_1;
CREATE INDEX idx_visit_concept_id_1 ON omopcdm.visit_occurrence (visit_concept_id ASC);

CREATE INDEX idx_visit_det_person_id_1 ON omopcdm.visit_detail (person_id ASC);
CLUSTER omopcdm.visit_detail USING idx_visit_det_person_id_1;
CREATE INDEX idx_visit_det_concept_id_1 ON omopcdm.visit_detail (visit_detail_concept_id ASC);
CREATE INDEX idx_visit_det_occ_id ON omopcdm.visit_detail (visit_occurrence_id ASC);

CREATE INDEX idx_condition_person_id_1 ON omopcdm.condition_occurrence (person_id ASC);
CLUSTER omopcdm.condition_occurrence USING idx_condition_person_id_1;
CREATE INDEX idx_condition_concept_id_1 ON omopcdm.condition_occurrence (condition_concept_id ASC);
CREATE INDEX idx_condition_visit_id_1 ON omopcdm.condition_occurrence (visit_occurrence_id ASC);

CREATE INDEX idx_drug_person_id_1 ON omopcdm.drug_exposure (person_id ASC);
CLUSTER omopcdm.drug_exposure USING idx_drug_person_id_1;
CREATE INDEX idx_drug_concept_id_1 ON omopcdm.drug_exposure (drug_concept_id ASC);
CREATE INDEX idx_drug_visit_id_1 ON omopcdm.drug_exposure (visit_occurrence_id ASC);

CREATE INDEX idx_procedure_person_id_1 ON omopcdm.procedure_occurrence (person_id ASC);
CLUSTER omopcdm.procedure_occurrence USING idx_procedure_person_id_1;
CREATE INDEX idx_procedure_concept_id_1 ON omopcdm.procedure_occurrence (procedure_concept_id ASC);
CREATE INDEX idx_procedure_visit_id_1 ON omopcdm.procedure_occurrence (visit_occurrence_id ASC);

CREATE INDEX idx_device_person_id_1 ON omopcdm.device_exposure (person_id ASC);
CLUSTER omopcdm.device_exposure USING idx_device_person_id_1;
CREATE INDEX idx_device_concept_id_1 ON omopcdm.device_exposure (device_concept_id ASC);
CREATE INDEX idx_device_visit_id_1 ON omopcdm.device_exposure (visit_occurrence_id ASC);

CREATE INDEX idx_measurement_person_id_1 ON omopcdm.measurement (person_id ASC);
CLUSTER omopcdm.measurement USING idx_measurement_person_id_1;
CREATE INDEX idx_measurement_concept_id_1 ON omopcdm.measurement (measurement_concept_id ASC);
CREATE INDEX idx_measurement_visit_id_1 ON omopcdm.measurement (visit_occurrence_id ASC);

CREATE INDEX idx_observation_person_id_1 ON omopcdm.observation (person_id ASC);
CLUSTER omopcdm.observation USING idx_observation_person_id_1;
CREATE INDEX idx_observation_concept_id_1 ON omopcdm.observation (observation_concept_id ASC);
CREATE INDEX idx_observation_visit_id_1 ON omopcdm.observation (visit_occurrence_id ASC);

CREATE INDEX idx_death_person_id_1 ON omopcdm.death (person_id ASC);
CLUSTER omopcdm.death USING idx_death_person_id_1;

CREATE INDEX idx_note_person_id_1 ON omopcdm.note (person_id ASC);
CLUSTER omopcdm.note USING idx_note_person_id_1;
CREATE INDEX idx_note_concept_id_1 ON omopcdm.note (note_type_concept_id ASC);
CREATE INDEX idx_note_visit_id_1 ON omopcdm.note (visit_occurrence_id ASC);

CREATE INDEX idx_note_nlp_note_id_1 ON omopcdm.note_nlp (note_id ASC);
CLUSTER omopcdm.note_nlp USING idx_note_nlp_note_id_1;
CREATE INDEX idx_note_nlp_concept_id_1 ON omopcdm.note_nlp (note_nlp_concept_id ASC);

CREATE INDEX idx_fact_relationship_id1 ON omopcdm.fact_relationship (domain_concept_id_1 ASC);
CREATE INDEX idx_fact_relationship_id2 ON omopcdm.fact_relationship (domain_concept_id_2 ASC);
CREATE INDEX idx_fact_relationship_id3 ON omopcdm.fact_relationship (relationship_concept_id ASC);

CREATE INDEX idx_location_id_1 ON omopcdm.location (location_id ASC);
CLUSTER omopcdm.location USING idx_location_id_1;

CREATE INDEX idx_care_site_id_1 ON omopcdm.care_site (care_site_id ASC);
CLUSTER omopcdm.care_site USING idx_care_site_id_1;

CREATE INDEX idx_provider_id_1 ON omopcdm.provider (provider_id ASC);
CLUSTER omopcdm.provider USING idx_provider_id_1;

CREATE INDEX idx_period_person_id_1 ON omopcdm.payer_plan_period (person_id ASC);
CLUSTER omopcdm.payer_plan_period USING idx_period_person_id_1;

CREATE INDEX idx_cost_event_id ON omopcdm.cost (cost_event_id ASC);

CREATE INDEX idx_metadata_concept_id_1 ON omopcdm.metadata (metadata_concept_id ASC);
CLUSTER omopcdm.metadata USING idx_metadata_concept_id_1;

ALTER TABLE omopcdm.PERSON
    ADD CONSTRAINT xpk_PERSON PRIMARY KEY (person_id);

ALTER TABLE omopcdm.VISIT_OCCURRENCE
    ADD CONSTRAINT xpk_VISIT_OCCURRENCE PRIMARY KEY (visit_occurrence_id);

ALTER TABLE omopcdm.VISIT_DETAIL
    ADD CONSTRAINT xpk_VISIT_DETAIL PRIMARY KEY (visit_detail_id);

ALTER TABLE omopcdm.CONDITION_OCCURRENCE
    ADD CONSTRAINT xpk_CONDITION_OCCURRENCE PRIMARY KEY (condition_occurrence_id);

ALTER TABLE omopcdm.DRUG_EXPOSURE
    ADD CONSTRAINT xpk_DRUG_EXPOSURE PRIMARY KEY (drug_exposure_id);

ALTER TABLE omopcdm.PROCEDURE_OCCURRENCE
    ADD CONSTRAINT xpk_PROCEDURE_OCCURRENCE PRIMARY KEY (procedure_occurrence_id);

ALTER TABLE omopcdm.DEVICE_EXPOSURE
    ADD CONSTRAINT xpk_DEVICE_EXPOSURE PRIMARY KEY (device_exposure_id);

ALTER TABLE omopcdm.MEASUREMENT
    ADD CONSTRAINT xpk_MEASUREMENT PRIMARY KEY (measurement_id);

ALTER TABLE omopcdm.OBSERVATION
    ADD CONSTRAINT xpk_OBSERVATION PRIMARY KEY (observation_id);

ALTER TABLE omopcdm.NOTE
    ADD CONSTRAINT xpk_NOTE PRIMARY KEY (note_id);

ALTER TABLE omopcdm.NOTE_NLP
    ADD CONSTRAINT xpk_NOTE_NLP PRIMARY KEY (note_nlp_id);

ALTER TABLE omopcdm.LOCATION
    ADD CONSTRAINT xpk_LOCATION PRIMARY KEY (location_id);

ALTER TABLE omopcdm.CARE_SITE
    ADD CONSTRAINT xpk_CARE_SITE PRIMARY KEY (care_site_id);

ALTER TABLE omopcdm.PROVIDER
    ADD CONSTRAINT xpk_PROVIDER PRIMARY KEY (provider_id);

ALTER TABLE omopcdm.PAYER_PLAN_PERIOD
    ADD CONSTRAINT xpk_PAYER_PLAN_PERIOD PRIMARY KEY (payer_plan_period_id);

ALTER TABLE omopcdm.COST
    ADD CONSTRAINT xpk_COST PRIMARY KEY (cost_id);