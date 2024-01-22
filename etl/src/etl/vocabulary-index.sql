-- primary keys
ALTER TABLE omopcdm.concept
    ADD CONSTRAINT xpk_concept PRIMARY KEY (concept_id);
ALTER TABLE omopcdm.vocabulary
    ADD CONSTRAINT xpk_vocabulary PRIMARY KEY (vocabulary_id);
ALTER TABLE omopcdm.domain
    ADD CONSTRAINT xpk_domain PRIMARY KEY (domain_id);
ALTER TABLE omopcdm.concept_class
    ADD CONSTRAINT xpk_concept_class PRIMARY KEY (concept_class_id);
ALTER TABLE omopcdm.concept_relationship
    ADD CONSTRAINT xpk_concept_relationship PRIMARY KEY (concept_id_1, concept_id_2, relationship_id);
ALTER TABLE omopcdm.relationship
    ADD CONSTRAINT xpk_relationship PRIMARY KEY (relationship_id);
ALTER TABLE omopcdm.concept_ancestor
    ADD CONSTRAINT xpk_concept_ancestor PRIMARY KEY (ancestor_concept_id, descendant_concept_id);
ALTER TABLE omopcdm.source_to_concept_map
    ADD CONSTRAINT xpk_source_to_concept_map PRIMARY KEY (source_vocabulary_id, target_concept_id, source_code, valid_end_date);
ALTER TABLE omopcdm.drug_strength
    ADD CONSTRAINT xpk_drug_strength PRIMARY KEY (drug_concept_id, ingredient_concept_id);

-- constraints
CREATE UNIQUE INDEX idx_concept_concept_id ON omopcdm.concept (concept_id ASC);
CLUSTER
omopcdm.concept USING idx_concept_concept_id;
CREATE INDEX idx_concept_code ON omopcdm.concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON omopcdm.concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON omopcdm.concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON omopcdm.concept (concept_class_id ASC);
CREATE INDEX idx_concept_id_varchar ON omopcdm.concept (cast(concept_id AS VARCHAR));
CREATE UNIQUE INDEX idx_vocabulary_vocabulary_id ON omopcdm.vocabulary (vocabulary_id ASC);
CLUSTER
omopcdm.vocabulary USING idx_vocabulary_vocabulary_id;
CREATE UNIQUE INDEX idx_domain_domain_id ON omopcdm.domain (domain_id ASC);
CLUSTER
omopcdm.domain USING idx_domain_domain_id;
CREATE UNIQUE INDEX idx_concept_class_class_id ON omopcdm.concept_class (concept_class_id ASC);
CLUSTER
omopcdm.concept_class USING idx_concept_class_class_id;
CREATE INDEX idx_concept_relationship_id_1 ON omopcdm.concept_relationship (concept_id_1 ASC);
CREATE INDEX idx_concept_relationship_id_2 ON omopcdm.concept_relationship (concept_id_2 ASC);
CREATE INDEX idx_concept_relationship_id_3 ON omopcdm.concept_relationship (relationship_id ASC);
CREATE UNIQUE INDEX idx_relationship_rel_id ON omopcdm.relationship (relationship_id ASC);
CLUSTER
omopcdm.relationship USING idx_relationship_rel_id;
CREATE INDEX idx_concept_synonym_id ON omopcdm.concept_synonym (concept_id ASC);
CLUSTER
omopcdm.concept_synonym USING idx_concept_synonym_id;
CREATE INDEX idx_concept_ancestor_id_1 ON omopcdm.concept_ancestor (ancestor_concept_id ASC);
CLUSTER
omopcdm.concept_ancestor USING idx_concept_ancestor_id_1;
CREATE INDEX idx_concept_ancestor_id_2 ON omopcdm.concept_ancestor (descendant_concept_id ASC);
CREATE INDEX idx_source_to_concept_map_id_3 ON omopcdm.source_to_concept_map (target_concept_id ASC);
CLUSTER
omopcdm.source_to_concept_map USING idx_source_to_concept_map_id_3;
CREATE INDEX idx_source_to_concept_map_id_1 ON omopcdm.source_to_concept_map (source_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_id_2 ON omopcdm.source_to_concept_map (target_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_code ON omopcdm.source_to_concept_map (source_code ASC);
CREATE INDEX idx_drug_strength_id_1 ON omopcdm.drug_strength (drug_concept_id ASC);
CLUSTER
omopcdm.drug_strength USING idx_drug_strength_id_1;
CREATE INDEX idx_drug_strength_id_2 ON omopcdm.drug_strength (ingredient_concept_id ASC);

-- foreign key constraints
ALTER TABLE omopcdm.concept
    ADD CONSTRAINT fpk_concept_domain FOREIGN KEY (domain_id) REFERENCES omopcdm.domain (domain_id);
ALTER TABLE omopcdm.concept
    ADD CONSTRAINT fpk_concept_class FOREIGN KEY (concept_class_id) REFERENCES omopcdm.concept_class (concept_class_id);
ALTER TABLE omopcdm.concept
    ADD CONSTRAINT fpk_concept_vocabulary FOREIGN KEY (vocabulary_id) REFERENCES omopcdm.vocabulary (vocabulary_id);
ALTER TABLE omopcdm.vocabulary
    ADD CONSTRAINT fpk_vocabulary_concept FOREIGN KEY (vocabulary_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.domain
    ADD CONSTRAINT fpk_domain_concept FOREIGN KEY (domain_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.concept_class
    ADD CONSTRAINT fpk_concept_class_concept FOREIGN KEY (concept_class_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.concept_relationship
    ADD CONSTRAINT fpk_concept_relationship_c_1 FOREIGN KEY (concept_id_1) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.concept_relationship
    ADD CONSTRAINT fpk_concept_relationship_c_2 FOREIGN KEY (concept_id_2) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.concept_relationship
    ADD CONSTRAINT fpk_concept_relationship_id FOREIGN KEY (relationship_id) REFERENCES omopcdm.relationship (relationship_id);
ALTER TABLE omopcdm.relationship
    ADD CONSTRAINT fpk_relationship_concept FOREIGN KEY (relationship_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.relationship
    ADD CONSTRAINT fpk_relationship_reverse FOREIGN KEY (reverse_relationship_id) REFERENCES omopcdm.relationship (relationship_id);
ALTER TABLE omopcdm.concept_synonym
    ADD CONSTRAINT fpk_concept_synonym_concept FOREIGN KEY (concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.concept_synonym
    ADD CONSTRAINT fpk_concept_synonym_language_concept FOREIGN KEY (language_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.concept_ancestor
    ADD CONSTRAINT fpk_concept_ancestor_concept_1 FOREIGN KEY (ancestor_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.concept_ancestor
    ADD CONSTRAINT fpk_concept_ancestor_concept_2 FOREIGN KEY (descendant_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.source_to_concept_map
    ADD CONSTRAINT fpk_source_to_concept_map_v_1 FOREIGN KEY (source_vocabulary_id) REFERENCES omopcdm.vocabulary (vocabulary_id);
ALTER TABLE omopcdm.source_to_concept_map
    ADD CONSTRAINT fpk_source_to_concept_map_v_2 FOREIGN KEY (target_vocabulary_id) REFERENCES omopcdm.vocabulary (vocabulary_id);
ALTER TABLE omopcdm.source_to_concept_map
    ADD CONSTRAINT fpk_source_to_concept_map_c_1 FOREIGN KEY (target_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.drug_strength
    ADD CONSTRAINT fpk_drug_strength_concept_1 FOREIGN KEY (drug_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.drug_strength
    ADD CONSTRAINT fpk_drug_strength_concept_2 FOREIGN KEY (ingredient_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.drug_strength
    ADD CONSTRAINT fpk_drug_strength_unit_1 FOREIGN KEY (amount_unit_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.drug_strength
    ADD CONSTRAINT fpk_drug_strength_unit_2 FOREIGN KEY (numerator_unit_concept_id) REFERENCES omopcdm.concept (concept_id);
ALTER TABLE omopcdm.drug_strength
    ADD CONSTRAINT fpk_drug_strength_unit_3 FOREIGN KEY (denominator_unit_concept_id) REFERENCES omopcdm.concept (concept_id);