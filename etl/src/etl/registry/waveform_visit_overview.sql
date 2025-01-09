-- To Run in ohdsi schema where dash manifest is located

CREATE TABLE public.waveform_person_time AS (
                                                WITH mit_linkage AS (
                                                                        SELECT name AS full_name,
                                                                               start_time,
                                                                               split_part(name, '/', 4) ::integer AS record_id
                                                                        FROM public.all_metadata_expanded
                                                                                 INNER JOIN public.mit_linked
                                                                                            ON split_part(name, '/', 4):: INTEGER = record_id
                                                WHERE container = 'mit'
                                                  AND mode = 'WAVE'
                                                  AND NAME LIKE '202412%'
                                            )
SELECT name,
       container,
       CASE
           WHEN container = 'columbia' THEN split_part(name, '/', 2)
           WHEN container = 'duke' THEN split_part(name, '/', 1)
           WHEN container = 'emory' THEN split_part(name, '/', 2)
           WHEN container = 'mayo' THEN split_part(split_part(name, '/', 2), '_', 1) -- No person in path
           WHEN container = 'mgh' THEN split_part(name, '/', 1) -- path leads with person for non-OMOP data
           WHEN container = 'mit' THEN split_part(name, '/', 2)
           WHEN container = 'nationwide' THEN split_part(name, '/', 1)
           WHEN container = 'pitts' THEN split_part(name, '/', 3)
           WHEN container = 'seattle' THEN split_part(name, '/', 1)
           WHEN container = 'tuft' THEN split_part(name, '/', 1)
           WHEN container = 'ucla' THEN replace(split_part(name, '/', 1), 'Person', '')
           WHEN container = 'uflorida' THEN split_part(name, '/', 1)
           WHEN container = 'uva' THEN split_part(name, '/', 2)
           END AS src_person_id,
       CASE
           WHEN container = 'columbia' THEN NULL
           WHEN container = 'duke' THEN concat(split_part(split_part(name, '/', -1), '_', 2), ' ',
                                               lpad(split_part(split_part(name, '/', -1), '_', 3), 6, '0'))::TIMESTAMP
			WHEN container = 'emory' AND NAME LIKE '2024%' THEN concat(split_part(split_part(NAME, '/', -1), '_', 2), ' ',  lpad(split_part(split_part(NAME, '/', -1), '_', 3), 6, '0'))::TIMESTAMP
			WHEN container = 'mayo' THEN split_part(split_part(NAME, '/', -1), '_', 2)::DATE::TIMESTAMP
			WHEN container = 'mgh' THEN concat(split_part(split_part(NAME, '/', -1), '_', 2), ' ',  lpad(split_part(split_part(NAME, '/', -1), '_', 3), 6, '0'))::TIMESTAMP
			WHEN container = 'mit' THEN linked.start_time
			WHEN container = 'nationwide' AND split_part(split_part(NAME, '/', -1), '_', 2) NOT LIKE '%parq%' AND extension != 'txt' THEN to_timestamp(split_part(split_part(NAME, '/', -1), '_', 2)::bigint)
			WHEN container = 'pitts' THEN concat(split_part(split_part(NAME, '/', -1), '_', 2), ' ',  lpad(split_part(split_part(NAME, '/', -1), '_', 3), 6, '0'))::TIMESTAMP
			WHEN container = 'seattle' THEN concat(SUBSTRING(split_part(split_part(NAME, '/', -1), '_', 2), 5, 4),
													SUBSTRING(split_part(split_part(NAME, '/', -1), '_', 2), 1, 2),
													SUBSTRING(split_part(split_part(NAME, '/', -1), '_', 2), 3, 2), ' ',
													'120000') ::TIMESTAMP
			WHEN container = 'tuft' THEN NULL
			WHEN container = 'ucla' THEN NULL
			WHEN container = 'uflorida' THEN NULL -- did not use naming convention
			WHEN container = 'uva' THEN concat(split_part(split_part(NAME, '/', -1), '_', 2), ' ',  lpad(split_part(split_part(NAME, '/', -1), '_', 3), 6, '0'))::TIMESTAMP
END
AS wave_time,
	   extension
 FROM PUBLIC.all_metadata_expanded
 LEFT JOIN mit_linkage linked ON full_name = NAME
 WHERE mode = 'WAVE'
 AND extension IS NOT NULL
 );

-- To run against the MERGE schema after transferring the table above and making the following tweaks:
-- updating container names
-- removing test data files and ensuring source id can be converted to bigint


CREATE TABLE public.waveform_visit_overview AS (
                                                   WITH wave_visits AS (
                                                                           SELECT a.name, MIN(visit_occurrence_id) AS vid
                                                                           FROM public.waveform_person_time a
                                                                                    LEFT JOIN (
                                                                                                  SELECT person_id AS pid,
                                                                                                         visit_occurrence_id,
                                                                                                         src_name,
                                                                                                         visit_start_datetime,
                                                                                                         visit_end_datetime
                                                                                                  FROM omopcdm.visit_occurrence
                                                                                              ) b
                                                                                              ON a.person_id = b.pid
                                                                                                  AND a.container =
                                                                                                      b.src_name
                                                                           WHERE wave_time >= visit_start_datetime - INTERVAL '1 day'*31
                                                       AND wave_time <= visit_end_datetime + INTERVAL '1 day'*31
                                                   GROUP BY a.name
                                               ),
visit_join AS (
SELECT a.*, b.vid AS visit_occurrence_id
FROM PUBLIC.waveform_person_time a
LEFT JOIN wave_visits b
ON a.name = b.name
),
omop_persons AS (
SELECT src_name, COUNT(*) AS cnt FROM omopcdm.person GROUP BY src_name
),
omop_visits AS (
SELECT src_name, COUNT(*) AS cnt FROM omopcdm.visit_occurrence GROUP BY src_name
)
SELECT COALESCE(container, c.src_name)                     AS site,
       MAX(c.cnt)                                          AS omop_persons,
       MAX(d.cnt)                                          AS omop_visits,
       COUNT(DISTINCT (a.name))                            AS wave_files,
       COUNT(DISTINCT (person_id))                         AS pers_w_wave,
       COUNT(DISTINCT (vid))                               AS visit_w_wave,
       array_to_string(array_agg(DISTINCT extension), ';') AS extension
FROM omop_persons c
         LEFT JOIN public.waveform_person_time a
                   ON c.src_name = a.container
         LEFT JOIN wave_visits b
                   ON a.name = b.name
         LEFT JOIN omop_visits d
                   ON c.src_name = d.src_name
GROUP BY COALESCE(container, c.src_name)
UNION
SELECT container                                           AS site,
       0                                                   AS omop_persons,
       0                                                   AS omop_visits,
       COUNT(DISTINCT (a.name))                            AS wave_files,
       0                                                   AS pers_w_wave,
       0                                                   AS visit_w_wave,
       array_to_string(array_agg(DISTINCT extension), ';') AS extension
FROM public.waveform_person_time a
WHERE container NOT IN (
                           SELECT DISTINCT src_name
                           FROM omopcdm.person
                       )
GROUP BY container );