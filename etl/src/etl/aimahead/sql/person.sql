WITH
    person_joined AS (
        SELECT
            NULL::bigint AS src_person_id,
            sk.s_key AS src_name,
            p.person_id,
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
        FROM aimahead.person p
        INNER JOIN public.aimahead_sample_60 s
        ON p.person_id = s.person_id
        JOIN persist.source_key sk ON src_name = sk.s_name
    )
INSERT INTO
    aimahead_60.person
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
    
