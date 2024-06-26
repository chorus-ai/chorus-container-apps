WITH
    condition_occurrence_joined AS (
                                       SELECT NULL::integer AS src_table_id,
                                              NULL::integer              AS src_person_id,
                                              NULL::integer     AS src_visit_occurrence_id,
                                              NULL::integer        AS src_visit_detail_id,
                                              CASE WHEN src_name = 'mgh' THEN '1'
                                                   WHEN src_name = 'mit' THEN '2'
                                                   WHEN src_name = 'nationwide' THEN '3'
                                                   WHEN src_name = 'pittsburgh' THEN '4'
                                                   WHEN src_name = 'seattle' THEN '5'
                                              END AS src_name,
                                              condition_occurrence_id,
                                              person_id,
                                              condition_concept_id,
                                              condition_start_date,
                                              condition_start_datetime,
                                              condition_end_date,
                                              condition_end_datetime,
                                              condition_type_concept_id,
                                              condition_status_concept_id,
                                              NULL AS stop_reason,
                                              visit_occurrence_id,
                                              visit_detail_id,
                                              NULL AS condition_source_value,
                                              condition_source_concept_id,
                                              NULL AS condition_status_source_value
                                       FROM msft_challenge.condition_occurrence co
                                       WHERE person_id IN (SELECT person_id FROM msft_challenge_80.person)
                                   )
INSERT INTO
   msft_challenge_80.condition_occurrence
SELECT
    condition_occurrence_id,
    person_id,
    condition_concept_id,
    condition_start_date,
    condition_start_datetime,
    condition_end_date,
    condition_end_datetime,
    condition_type_concept_id,
    condition_status_concept_id,
    stop_reason,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    condition_source_value,
    condition_source_concept_id,
    condition_status_source_value,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    condition_occurrence_joined;
    
