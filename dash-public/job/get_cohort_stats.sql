DROP TABLE IF EXISTS public.cohort_stats;
CREATE TABLE public.cohort_stats AS (
SELECT count(*),
       src_name,
       cohort_definition_id,
       CASE WHEN id IS NOT NULL
           THEN array_agg(distinct(word))
           END as words,
       description
FROM omopcdm.person
    LEFT JOIN omopcdm.cohort
        ON person_id = subject_id
    LEFT JOIN (SELECT unnest(ids) AS id,
                      word
               FROM public.cohort_words) w
        ON cohort_definition_id = w.id
    LEFT JOIN (select description,
                      id AS cid
               FROM public.cohort_def_ref) r
        ON cohort_definition_id = r.cid
GROUP BY src_name, cohort_definition_id, id, description);