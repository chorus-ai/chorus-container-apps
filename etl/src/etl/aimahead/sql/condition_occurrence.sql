WITH
    condition_occurrence_joined AS (
                                       SELECT NULL::integer AS src_table_id,
                                              NULL::integer              AS src_person_id,
                                              NULL::integer     AS src_visit_occurrence_id,
                                              NULL::integer        AS src_visit_detail_id,
                                              sk.s_key AS src_name,
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
                                       FROM aimahead.condition_occurrence co
                                       JOIN persist.source_key sk ON co.src_name = sk.s_name
                                       WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
                                       AND condition_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
                                   )
INSERT INTO
   aimahead_60.condition_occurrence
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
    
