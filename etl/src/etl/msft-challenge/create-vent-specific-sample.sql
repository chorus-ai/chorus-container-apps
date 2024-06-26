CREATE TABLE public.vent_persons AS (
                                        SELECT DISTINCT person_id
                                        FROM msft_challenge.measurement
                                        WHERE measurement_concept_id = 44786857
                                    );

CREATE TABLE public.sample_80 AS (
                                     SELECT *
                                     FROM public.vent_persons
                                     ORDER BY random() LIMIT (FLOOR((SELECT COUNT(*) FROM PUBLIC.vent_persons) * 0.80))
                                 );

INSERT INTO
    public.sample_80 (
                         SELECT person_id
                         FROM msft_challenge.person
                         WHERE person_id NOT IN (
                                                    SELECT person_id
                                                    FROM public.vent_persons
                                                )
                         ORDER BY random() LIMIT (FLOOR((SELECT COUNT(*) FROM msft_challenge.person) * 0.80) - (SELECT COUNT(*) FROM PUBLIC.vent_persons))
                     );


SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY value_as_number) FROM msft_challenge.measurement WHERE person_id IN (SELECT person_id from public.sample_80) AND measurement_concept_id = 44786857;

SELECT PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY value_as_number) FROM msft_challenge.measurement WHERE person_id NOT IN (SELECT person_id from public.sample_80) AND measurement_concept_id = 44786857;