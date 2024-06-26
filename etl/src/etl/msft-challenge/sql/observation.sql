WITH
    observation_joined AS (
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
            observation_id,
            person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            NULL  AS value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            visit_occurrence_id,
            visit_detail_id,
            NULL  AS observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            NULL  AS value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM msft_challenge.observation o
           WHERE person_id IN (SELECT person_id FROM msft_challenge_80.person)
    )
INSERT INTO
    msft_challenge_80.observation
SELECT
    observation_id,
    person_id,
    observation_concept_id,
    observation_date,
    observation_datetime,
    observation_type_concept_id,
    value_as_number,
    value_as_string,
    value_as_concept_id,
    qualifier_concept_id,
    unit_concept_id,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    observation_source_value,
    observation_source_concept_id,
    unit_source_value,
    qualifier_source_value,
    value_source_value,
    observation_event_id,
    obs_event_field_concept_id,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    observation_joined;
