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
