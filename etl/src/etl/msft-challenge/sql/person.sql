WITH
    person_joined AS (
        SELECT
            NULL AS src_person_id,
            CASE WHEN src_name = 'mgh' THEN '1'
                   WHEN src_name = 'mit' THEN '2'
                   WHEN src_name = 'nationwide' THEN '3'
                   WHEN src_name = 'pittsburgh' THEN '4'
                   WHEN src_name = 'seattle' THEN '5'
              END AS src_name,
            person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            NULL AS person_source_value,
            NULL AS gender_source_value,
            gender_source_concept_id,
            NULL AS race_source_value,
            race_source_concept_id,
            NULL AS ethnicity_source_value,
            ethnicity_source_concept_id
        FROM msft_challenge.person p
        INNER JOIN public.sample_80 s
        ON p.person_id = s.person_id
    )
INSERT INTO
    msft_challenge_80.person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined ;
    
