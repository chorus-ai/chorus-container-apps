WITH
    death_joined AS (
        SELECT
            NULL::integer AS src_person_id,
            sk.s_key AS src_name,
            person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            CASE WHEN cause_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
                THEN cause_concept_id
                END AS cause_concept_id,
            NULL AS cause_source_value,
            CASE WHEN cause_source_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
                THEN cause_source_concept_id
                END AS cause_source_concept_id
        FROM aimahead.death d
        JOIN persist.source_key sk ON src_name = sk.s_name
        WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
    )
INSERT INTO
    aimahead_60.death
SELECT
    person_id,
    death_date,
    death_datetime,
    death_type_concept_id,
    cause_concept_id,
    cause_source_value,
    cause_source_concept_id,
    src_person_id,
    src_name
FROM
    death_joined;
    
