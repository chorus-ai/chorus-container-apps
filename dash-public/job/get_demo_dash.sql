DROP TABLE IF EXISTS public.demo_dash;

CREATE TABLE public.demo_dash AS (
select
    CASE WHEN src_name = 'mit'
        then 180 + date_part('year', current_date) - year_of_birth
        else date_part('year', current_date) - year_of_birth
    END AS age,
    c0.concept_name AS sex_name,
    c1.concept_name AS race_name,
    c2.concept_name AS ethnicity_name,
    src_name from omopcdm.person
        LEFT JOIN omopcdm.concept c1
            ON race_concept_id = c1.concept_id
        LEFT JOIN omopcdm.concept c2
            ON ethnicity_concept_id = c2.concept_id
        LEFT JOIN omopcdm.concept c0
            ON gender_concept_id = c0.concept_id);