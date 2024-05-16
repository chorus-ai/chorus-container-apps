CREATE INDEX idx_person_id ON person (person_id ASC);
CLUSTER person USING idx_person_id;
CREATE INDEX idx_gender ON person (gender_concept_id ASC);

CREATE INDEX idx_visit_person_id_1 ON visit_occurrence (person_id ASC);
CLUSTER visit_occurrence USING idx_visit_person_id_1;
CREATE INDEX idx_visit_concept_id_1 ON visit_occurrence (visit_concept_id ASC);

CREATE INDEX idx_visit_det_person_id_1 ON visit_detail (person_id ASC);
CLUSTER visit_detail USING idx_visit_det_person_id_1;
CREATE INDEX idx_visit_det_concept_id_1 ON visit_detail (visit_detail_concept_id ASC);
CREATE INDEX idx_visit_det_occ_id ON visit_detail (visit_occurrence_id ASC);

CREATE INDEX idx_condition_person_id_1 ON condition_occurrence (person_id ASC);
CLUSTER condition_occurrence USING idx_condition_person_id_1;
CREATE INDEX idx_condition_concept_id_1 ON condition_occurrence (condition_concept_id ASC);
CREATE INDEX idx_condition_visit_id_1 ON condition_occurrence (visit_occurrence_id ASC);

CREATE INDEX idx_drug_person_id_1 ON drug_exposure (person_id ASC);
CLUSTER drug_exposure USING idx_drug_person_id_1;
CREATE INDEX idx_drug_concept_id_1 ON drug_exposure (drug_concept_id ASC);
CREATE INDEX idx_drug_visit_id_1 ON drug_exposure (visit_occurrence_id ASC);

CREATE INDEX idx_procedure_person_id_1 ON procedure_occurrence (person_id ASC);
CLUSTER procedure_occurrence USING idx_procedure_person_id_1;
CREATE INDEX idx_procedure_concept_id_1 ON procedure_occurrence (procedure_concept_id ASC);
CREATE INDEX idx_procedure_visit_id_1 ON procedure_occurrence (visit_occurrence_id ASC);

CREATE INDEX idx_device_person_id_1 ON device_exposure (person_id ASC);
CLUSTER device_exposure USING idx_device_person_id_1;
CREATE INDEX idx_device_concept_id_1 ON device_exposure (device_concept_id ASC);
CREATE INDEX idx_device_visit_id_1 ON device_exposure (visit_occurrence_id ASC);

CREATE INDEX idx_measurement_person_id_1 ON measurement (person_id ASC);
CLUSTER measurement USING idx_measurement_person_id_1;
CREATE INDEX idx_measurement_concept_id_1 ON measurement (measurement_concept_id ASC);
CREATE INDEX idx_measurement_visit_id_1 ON measurement (visit_occurrence_id ASC);

CREATE INDEX idx_observation_person_id_1 ON observation (person_id ASC);
CLUSTER observation USING idx_observation_person_id_1;
CREATE INDEX idx_observation_concept_id_1 ON observation (observation_concept_id ASC);
CREATE INDEX idx_observation_visit_id_1 ON observation (visit_occurrence_id ASC);

CREATE INDEX idx_death_person_id_1 ON death (person_id ASC);
CLUSTER death USING idx_death_person_id_1;

CREATE INDEX idx_note_person_id_1 ON note (person_id ASC);
CLUSTER note USING idx_note_person_id_1;
CREATE INDEX idx_note_concept_id_1 ON note (note_type_concept_id ASC);
CREATE INDEX idx_note_visit_id_1 ON note (visit_occurrence_id ASC);

CREATE INDEX idx_note_nlp_note_id_1 ON note_nlp (note_id ASC);
CLUSTER note_nlp USING idx_note_nlp_note_id_1;
CREATE INDEX idx_note_nlp_concept_id_1 ON note_nlp (note_nlp_concept_id ASC);

CREATE INDEX idx_fact_relationship_id1 ON fact_relationship (domain_concept_id_1 ASC);
CREATE INDEX idx_fact_relationship_id2 ON fact_relationship (domain_concept_id_2 ASC);
CREATE INDEX idx_fact_relationship_id3 ON fact_relationship (relationship_concept_id ASC);

CREATE INDEX idx_location_id_1 ON location (location_id ASC);
CLUSTER location USING idx_location_id_1;

CREATE INDEX idx_care_site_id_1 ON care_site (care_site_id ASC);
CLUSTER care_site USING idx_care_site_id_1;

CREATE INDEX idx_provider_id_1 ON provider (provider_id ASC);
CLUSTER provider USING idx_provider_id_1;

CREATE INDEX idx_period_person_id_1 ON payer_plan_period (person_id ASC);
CLUSTER payer_plan_period USING idx_period_person_id_1;

CREATE INDEX idx_cost_event_id ON cost (cost_event_id ASC);

CREATE INDEX idx_metadata_concept_id_1 ON metadata (metadata_concept_id ASC);
CLUSTER metadata USING idx_metadata_concept_id_1;

ALTER TABLE PERSON
    ADD CONSTRAINT xpk_PERSON PRIMARY KEY (person_id);

ALTER TABLE VISIT_OCCURRENCE
    ADD CONSTRAINT xpk_VISIT_OCCURRENCE PRIMARY KEY (visit_occurrence_id);

ALTER TABLE VISIT_DETAIL
    ADD CONSTRAINT xpk_VISIT_DETAIL PRIMARY KEY (visit_detail_id);

ALTER TABLE CONDITION_OCCURRENCE
    ADD CONSTRAINT xpk_CONDITION_OCCURRENCE PRIMARY KEY (condition_occurrence_id);

ALTER TABLE DRUG_EXPOSURE
    ADD CONSTRAINT xpk_DRUG_EXPOSURE PRIMARY KEY (drug_exposure_id);

ALTER TABLE PROCEDURE_OCCURRENCE
    ADD CONSTRAINT xpk_PROCEDURE_OCCURRENCE PRIMARY KEY (procedure_occurrence_id);

ALTER TABLE DEVICE_EXPOSURE
    ADD CONSTRAINT xpk_DEVICE_EXPOSURE PRIMARY KEY (device_exposure_id);

ALTER TABLE MEASUREMENT
    ADD CONSTRAINT xpk_MEASUREMENT PRIMARY KEY (measurement_id);

ALTER TABLE OBSERVATION
    ADD CONSTRAINT xpk_OBSERVATION PRIMARY KEY (observation_id);

ALTER TABLE NOTE
    ADD CONSTRAINT xpk_NOTE PRIMARY KEY (note_id);

ALTER TABLE NOTE_NLP
    ADD CONSTRAINT xpk_NOTE_NLP PRIMARY KEY (note_nlp_id);

ALTER TABLE LOCATION
    ADD CONSTRAINT xpk_LOCATION PRIMARY KEY (location_id);

ALTER TABLE CARE_SITE
    ADD CONSTRAINT xpk_CARE_SITE PRIMARY KEY (care_site_id);

ALTER TABLE PROVIDER
    ADD CONSTRAINT xpk_PROVIDER PRIMARY KEY (provider_id);

ALTER TABLE PAYER_PLAN_PERIOD
    ADD CONSTRAINT xpk_PAYER_PLAN_PERIOD PRIMARY KEY (payer_plan_period_id);

ALTER TABLE COST
    ADD CONSTRAINT xpk_COST PRIMARY KEY (cost_id);