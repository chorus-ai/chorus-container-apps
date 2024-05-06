CREATE VIEW omopcdm.concept AS SELECT * FROM vocabulary.concept;

CREATE VIEW omopcdm.concept_relationship AS SELECT * FROM vocabulary.concept_relationship;

CREATE VIEW omopcdm.concept_ancestor AS SELECT * FROM vocabulary.concept_ancestor;

CREATE VIEW omopcdm.concept_class AS SELECT * FROM vocabulary.concept_class;

CREATE VIEW omopcdm.concept_recommended AS SELECT * FROM vocabulary.concept_recommended;

CREATE VIEW omopcdm.concept_synonym AS SELECT * FROM vocabulary.concept_synonym;

CREATE VIEW omopcdm.domain AS SELECT * FROM vocabulary.domain;

CREATE VIEW omopcdm.drug_strength AS SELECT * FROM vocabulary.drug_strength;

CREATE VIEW omopcdm.relationship AS SELECT * FROM vocabulary.relationship;

CREATE VIEW omopcdm.source_to_concept_map AS SELECT * FROM vocabulary.source_to_concept_map;

CREATE VIEW omopcdm.vocabulary AS SELECT * FROM vocabulary.vocabulary;