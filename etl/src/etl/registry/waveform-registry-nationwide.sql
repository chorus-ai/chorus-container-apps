CREATE TABLE public.waveform_reg AS (
                                        WITH extract_timestamp AS (
                                                                      SELECT person,
                                                                             name,
                                                                             to_timestamp(split_part(filename, '_', 2)::bigint) AS filedatetime
                                                                      FROM public.allfiles
                                                                      WHERE LOWER(modality) LIKE 'wave%'
                                                                        AND extension IS NOT NULL
                                                                        AND split_part(filename, '_', 2) NOT LIKE '%parq%'
                                                                  ),
                                             converted AS (
                                                                      SELECT person, name, filedatetime AS converted_stamp
                                                                      FROM extract_timestamp
                                                                  ),
                                             joined_visit AS (
                                                                      SELECT c.*,
                                                                             visit_occurrence_id,
                                                                             person_id,
                                                                             visit_start_date,
                                                                             visit_end_date
                                                                      FROM converted c
                                                                               INNER JOIN omopcdm.visit_occurrence v
                                                                                          ON c.person::bigint = v.person_id::bigint
                                        WHERE C.converted_stamp BETWEEN visit_start_date - INTERVAL '1' DAY
                                          AND visit_end_date + INTERVAL '1' DAY
                                    ),
	 waveform_registry AS (
	 SELECT row_number() OVER (ORDER BY NAME) + 2001000000 AS file_id,
            MIN(person_id) AS person_id,
			NULL AS group_id,
			MIN(visit_occurrence_id) AS visit_occurrence_id,
			MIN(converted_stamp) AS file_datetime,
			NAME AS src_file,
			NAME AS trg_file
			FROM joined_visit
			GROUP BY NAME
			)
SELECT *
FROM waveform_registry );