CREATE TABLE omopcdm.src_condition_occurrence
(
condition_occurrence_id TEXT,
person_id TEXT,
condition_concept_id TEXT,
condition_start_date TEXT,
condition_type_concept_id TEXT,
condition_source_value TEXT,
condition_source_name TEXT
);

CREATE TABLE omopcdm.src_death
(
    person_id               TEXT,
    death_date              TEXT
);

CREATE TABLE omopcdm.src_drug_exposure
(
    drug_exposure_id TEXT,
person_id TEXT,
drug_concept_id TEXT,
drug_exposure_start_date TEXT,
drug_exposure_end_date TEXT,
drug_type_concept_id TEXT
);

CREATE TABLE omopcdm.src_measurement
(
    measurement_id TEXT,
person_id TEXT,
measurement_concept_id TEXT,
measurement_date TEXT,
measurement_type_concept_id TEXT,
measurement_source_name TEXT,
measurement_source_value TEXT,
measurement_source_numeric_value TEXT,
unit_source_value TEXT
);


CREATE TABLE omopcdm.src_person
(
   person_id TEXT,
gender_concept_id TEXT,
year_of_birth TEXT,
month_of_birth TEXT,
day_of_birth TEXT,
birth_datetime TEXT,
race_concept_id TEXT,
ethnicity_concept_id TEXT,
gender_source_value TEXT,
race_source_value TEXT,
ethnicity_source_value TEXT
);

CREATE TABLE omopcdm.src_procedure_occurrence
(
    procedure_occurrence_id TEXT,
person_id TEXT,
procedure_concept_id TEXT,
procedure_start_date TEXT,
procedure_type_concept_id TEXT,
procedure_source_name TEXT
);

CREATE TABLE omopcdm.src_visit_occurrence
(
   visit_occurrence_id TEXT,
person_id TEXT,
visit_concept_id TEXT,
visit_start_date TEXT,
visit_end_date TEXT,
visit_type_concept_id TEXT,
visit_source_value TEXT
);


CREATE TABLE omopcdm.src_visit_detail
(
visit_detail_id TEXT,
visit_occurrence_id TEXT,
person_id TEXT,
visit_concept_id TEXT,
visit_start_date TEXT,
visit_end_date TEXT,
visit_type_concept_id TEXT,
visit_source_value TEXT,
icu_type_source_value TEXT
);
