CREATE TABLE public.aimahead_vent AS (
                                        SELECT DISTINCT person_id
                                        FROM aimahead.measurement
                                        WHERE measurement_concept_id = 44786857
                                    );

CREATE TABLE public.aimahead_sample_60 AS (
                                     SELECT *
                                     FROM public.aimahead_vent
                                     ORDER BY random() LIMIT (FLOOR((SELECT COUNT(*) FROM public.aimahead_vent) * 0.80))
                                 );

INSERT INTO
    public.aimahead_sample_60 (
                         SELECT person_id
                         FROM aimahead.person
                         WHERE person_id NOT IN (
                                                    SELECT person_id
                                                    FROM public.aimahead_vent
                                                )
                         ORDER BY random() LIMIT (FLOOR((SELECT COUNT(*) FROM aimahead.person) * 0.80) - (SELECT COUNT(*) FROM public.aimahead_vent))
                     );


SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY value_as_number) FROM aimahead.measurement WHERE person_id IN (SELECT person_id from public.aimahead_sample_60) AND measurement_concept_id = 44786857;

SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY value_as_number) FROM aimahead.measurement WHERE person_id NOT IN (SELECT person_id from public.aimahead_sample_60) AND measurement_concept_id = 44786857;