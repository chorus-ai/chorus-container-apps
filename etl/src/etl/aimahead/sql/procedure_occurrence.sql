WITH
    procedure_occurrence_joined AS (
        SELECT
            NULL::bigint AS src_table_id,
            NULL::bigint AS src_person_id,
            NULL::bigint AS src_visit_occurrence_id,
            NULL::bigint AS src_visit_detail_id,
            sk.s_key AS src_name,
            procedure_occurrence_id,
            person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            visit_occurrence_id,
            visit_detail_id,
            NULL AS procedure_source_value,
            procedure_source_concept_id,
            NULL AS modifier_source_value
        FROM aimahead.procedure_occurrence p
           JOIN persist.source_key sk ON p.src_name = sk.s_name
           WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
           AND procedure_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
    )
INSERT INTO
    aimahead_60.procedure_occurrence
SELECT
    procedure_occurrence_id,
    person_id,
    procedure_concept_id,
    procedure_date,
    procedure_datetime,
    procedure_end_date,
    procedure_end_datetime,
    procedure_type_concept_id,
    modifier_concept_id,
    quantity,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    procedure_source_value,
    procedure_source_concept_id,
    modifier_source_value,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    procedure_occurrence_joined;
