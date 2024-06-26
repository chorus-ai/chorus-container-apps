WITH
    visit_detail_joined AS (
        SELECT
            NULL AS src_visit_detail_id,
            NULL AS src_visit_occurrence_id,
            NULL AS src_person_id,
            NULL AS src_prec_visit_detail_id,
            NULL AS src_parent_visit_detail_id,
            CASE WHEN src_name = 'mgh' THEN '1'
                   WHEN src_name = 'mit' THEN '2'
                   WHEN src_name = 'nationwide' THEN '3'
                   WHEN src_name = 'pittsburgh' THEN '4'
                   WHEN src_name = 'seattle' THEN '5'
              END AS src_name,
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
        FROM msft_challenge.visit_detail v
        WHERE person_id IN (SELECT person_id FROM msft_challenge_80.person)
    )
INSERT INTO
msft_challenge_80.visit_detail
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
