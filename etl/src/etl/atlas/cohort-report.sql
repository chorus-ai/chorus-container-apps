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
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'columbia'), 0)   AS columbia,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'duke'), 0)       AS duke,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'emory'), 0)      AS emory,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'mayo'), 0)       AS mayo,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'newmexico'), 0)  AS newmexico,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'ucsf'), 0)       AS ucsf,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'mgh'), 0)        AS mgh,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'mit'), 0)        AS mit,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'nationwide'), 0) AS nationwide,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'pittsburgh'), 0) AS pittsburgh,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'seattle'), 0)    AS seattle,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'ucla'), 0)       AS ucla,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'florida'), 0)    AS florida,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'tufts'), 0)      AS tufts,
                                                                         COALESCE(SUM(cnt) filter(WHERE src_name = 'virginia'), 0)   AS virginia
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
                                                                                               )::FLOAT * 100) ::numeric(5,1) AS percent_merge,
                                                                         floor(AVG(columbia))             AS cnt_columbia,
                                                                         floor(AVG(duke))             AS cnt_duke,
                                                                         floor(AVG(emory))      AS cnt_emory,
                                                                         floor(AVG(mayo))      AS cnt_mayo,
                                                                         floor(AVG(newmexico))         AS cnt_newmexico,
                                                                         floor(AVG(ucsf))            AS cnt_ucsf,
                                                                         floor(AVG(mgh))             AS cnt_mgh,
                                                                         floor(AVG(mit))             AS cnt_mit,
                                                                         floor(AVG(nationwide))      AS cnt_nationwide,
                                                                         floor(AVG(pittsburgh))      AS cnt_pittsburgh,
                                                                         floor(AVG(seattle))         AS cnt_seattle,
                                                                         floor(AVG(ucla))            AS cnt_ucla,
                                                                         floor(AVG(florida))         AS cnt_florida,
                                                                         floor(AVG(tufts))            AS cnt_tufts,
                                                                         floor(AVG(virginia))            AS cnt_virginia
                                                                  FROM cohort_cnt cc
                                                                           INNER JOIN public.cohort_def_ref cd ON cc.cohort_definition_id = cd.id
                                                                           INNER JOIN source_cnt_pivot cp ON cc.cohort_definition_id = cp.cid
                                                                  GROUP BY LOWER(TRIM(cd.description))
                                                              )
                                           SELECT *
                                           FROM grouped_list
                                           ORDER BY cnt_merge DESC
                                       );