WITH cohort_cnt AS (
                       SELECT cohort_definition_id, COUNT(DISTINCT subject_id) AS cnt
                       FROM omopcdm.cohort
                       GROUP BY cohort_definition_id
                       ORDER BY 2 DESC
                   ),
     grouped_list AS (
                       SELECT array_agg(cd.id)            AS id_list,
                              LOWER(TRIM(cd.description)) AS description,
                              floor(AVG(cc.cnt))          AS cnt,
                              (AVG(cc.cnt::float) / (
                                                        SELECT COUNT(*)
                                                        FROM omopcdm.person
                                                    )::FLOAT * 100) ::numeric(5,1) AS percent_patients
                       FROM cohort_cnt cc
                                INNER JOIN omopcdm.cohort_def_ref cd ON cc.cohort_definition_id = cd.id
                       GROUP BY LOWER(TRIM(cd.description))
                   )
SELECT *
FROM grouped_list
ORDER BY cnt DESC;