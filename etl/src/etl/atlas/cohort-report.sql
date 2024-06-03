CREATE TABLE omopcdm.cohort_reports AS (
                                           WITH cohort_cnt AS (
                                                                  SELECT cohort_definition_id, COUNT(DISTINCT subject_id) AS cnt
                                                                  FROM omopcdm.cohort
                                                                  GROUP BY cohort_definition_id
                                                                  ORDER BY 2 DESC
                                                              ),
                                                source_cnt AS (
                                                                  SELECT cohort_definition_id, src_name, COUNT(DISTINCT subject_id) AS cnt
                                                                  FROM omopcdm.cohort c
                                                                           INNER JOIN omopcdm.person p
                                                                                      ON c.subject_id = p.person_id
                                                                  GROUP BY c.cohort_definition_id,
                                                                           p.src_name
                                                              ),
                                                source_cnt_pivot AS (
                                                                  SELECT cohort_definition_id                                        AS cid,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'mgh'), 0)        AS mgh,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'mit'), 0)        AS mit,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'nationwide'), 0) AS nationwide,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'pittsburgh'), 0) AS pittsburgh,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'seattle'), 0)    AS seattle,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'ucla'), 0)       AS ucla
                                                                  FROM source_cnt
                                                                  GROUP BY cohort_definition_id
                                                              ),
                                                grouped_list AS (
                                                                  SELECT array_agg(cd.id)            AS id_list,
                                                                         LOWER(TRIM(cd.description)) AS description,
                                                                         floor(AVG(cc.cnt))          AS cnt_merge,
                                                                         (AVG(cc.cnt::float) / (
                                                                                                   SELECT COUNT(*)
                                                                                                   FROM omopcdm.person
                                                                                               )::FLOAT * 100) ::numeric(5,1) AS percent_merge, floor(AVG(mgh)) AS cnt_mgh,
                                                                         floor(AVG(mit))             AS cnt_mit,
                                                                         floor(AVG(nationwide))      AS cnt_nationwide,
                                                                         floor(AVG(pittsburgh))      AS cnt_pittsburgh,
                                                                         floor(AVG(seattle))         AS cnt_seattle,
                                                                         floor(AVG(ucla))            AS cnt_ucla
                                                                  FROM cohort_cnt cc
                                                                           INNER JOIN omopcdm.cohort_def_ref cd ON cc.cohort_definition_id = cd.id
                                                                           INNER JOIN source_cnt_pivot cp ON cc.cohort_definition_id = cp.cid
                                                                  GROUP BY LOWER(TRIM(cd.description))
                                                              )
                                           SELECT *
                                           FROM grouped_list
                                           ORDER BY cnt_merge DESC
                                       );