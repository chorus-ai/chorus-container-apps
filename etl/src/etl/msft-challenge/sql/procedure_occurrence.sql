WITH
    procedure_occurrence_joined AS (
        SELECT
            NULL AS src_table_id,
            NULL AS src_person_id,
            NULL AS src_visit_occurrence_id,
            NULL AS src_visit_detail_id,
            CASE WHEN src_name = 'mgh' THEN '1'
                   WHEN src_name = 'mit' THEN '2'
                   WHEN src_name = 'nationwide' THEN '3'
                   WHEN src_name = 'pittsburgh' THEN '4'
                   WHEN src_name = 'seattle' THEN '5'
              END AS src_name,
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
        FROM msft_challenge.procedure_occurrence p
           WHERE person_id IN (SELECT person_id FROM msft_challenge_80.person)
    )
INSERT INTO
    msft_challenge_80.procedure_occurrence
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
