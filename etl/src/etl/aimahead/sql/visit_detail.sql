WITH
    visit_detail_joined AS (
        SELECT
            NULL::bigint AS src_visit_detail_id,
            NULL::bigint AS src_visit_occurrence_id,
            NULL::bigint AS src_person_id,
            NULL::bigint::bigint AS src_prec_visit_detail_id,
            NULL::bigint AS src_parent_visit_detail_id,
            sk.s_key AS src_name,
            visit_detail_id,
            person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            NULL AS visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            NULL AS admitted_from_source_value,
            discharged_to_concept_id,
            NULL AS discharged_to_source_value,
            preceding_visit_detail_id,
            parent_visit_detail_id,
            visit_occurrence_id
        FROM aimahead.visit_detail v
        JOIN persist.source_key sk ON src_name = sk.s_name
        WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
    )
INSERT INTO
aimahead_60.visit_detail
SELECT
    visit_detail_id,
    person_id,
    visit_detail_concept_id,
    visit_detail_start_date,
    visit_detail_start_datetime,
    visit_detail_end_date,
    visit_detail_end_datetime,
    visit_detail_type_concept_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    visit_detail_source_value,
    visit_detail_source_concept_id,
    admitted_from_concept_id,
    admitted_from_source_value,
    discharged_to_concept_id,
    discharged_to_source_value,
    preceding_visit_detail_id,
    parent_visit_detail_id,
    visit_occurrence_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_prec_visit_detail_id,
    src_parent_visit_detail_id,
    src_name
FROM
    visit_detail_joined;
