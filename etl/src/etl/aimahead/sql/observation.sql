WITH
    observation_joined AS (
        SELECT
            NULL::bigint AS src_table_id,
            NULL::bigint AS src_person_id,
            NULL::bigint AS src_visit_occurrence_id,
            NULL::bigint AS src_visit_detail_id,
            sk.s_key AS src_name,
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
        FROM aimahead.observation o
        JOIN persist.source_key sk ON o.src_name = sk.s_name
           WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
           AND observation_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
    )
INSERT INTO
    aimahead_60.observation
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
