WITH
    death_joined AS (
        SELECT
            NULL::integer AS src_person_id,
            CASE WHEN src_name = 'mgh' THEN '1'
                 WHEN src_name = 'mit' THEN '2'
                 WHEN src_name = 'nationwide' THEN '3'
                 WHEN src_name = 'pittsburgh' THEN '4'
                 WHEN src_name = 'seattle' THEN '5'
            END AS src_name,
            person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM msft_challenge.death d
        WHERE person_id IN (SELECT person_id FROM msft_challenge_80.person)

    )
INSERT INTO
    msft_challenge_80.death
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
    
