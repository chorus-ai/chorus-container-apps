CREATE TABLE msft_challenge_80.waveform_registry AS (
WITH grouped_wfdb AS (
    SELECT person,
               array_to_string(((string_to_array(name, '/'))[1:3]), '/') AS path,
               'wfdb' AS format,
			   to_timestamp(split_part(split_part(name, '/', 3), '_', 2), 'YYYYmmDDHHmiSS') AS start_date,
			   split_part(name, '/', 1) AS src_name
        FROM public.allfiles
        WHERE NULLIF(split_part(name, '/', 4), '') IS NOT NULL
        GROUP BY array_to_string(((string_to_array(name, '/'))[1:3]), '/'),
		         person,
				 split_part(split_part(name, '/', 3), '_', 2),
				 split_part(name, '/', 1)
), parquet_paths AS (
    SELECT person,
	       array_to_string(((string_to_array(name, '/'))[1:3]), '/') AS path,
	       'parquet' AS format,
		   to_timestamp(split_part(filename, '_', 1), 'YYYYmmDDHHmiSS') AS start_date,
		   split_part(name, '/', 1) AS src_name
	FROM public.allfiles
	WHERE NULLIF(split_part(name, '/', 4), '') IS NULL
	AND NULLIF(split_part(name, '/', 3), '') IS NOT NULL
	AND NULLIF(split_part(split_part(name, '/', 3), '.', 2), '') IS NOT NULL
)
SELECT * FROM grouped_wfdb WHERE person::integer IN (SELECT person_id FROM msft_challenge_80.person)
UNION ALL
SELECT * FROM parquet_paths WHERE person::integer IN (SELECT person_id FROM msft_challenge_80.person))
;

INSERT INTO msft_challenge_80.procedure_occurrence
SELECT row_number()                 over (ORDER BY person) + 2001000000 AS procedure_occurrence_id, person_id AS person_id,
       CAST(4141651 AS INTEGER)  AS procedure_concept_id, -- Measuring and Monitoring Procedure
       start_date::date AS procedure_date, start_date::timestamp AS procedure_datetime, CAST(NULL AS DATE) AS procedure_end_date,
       CAST(NULL AS TIMESTAMP)   AS procedure_end_datetime,
       CAST(32880 AS INTEGER)    AS procedure_type_concept_id,
       CAST(NULL AS INTEGER)     AS modifier_concept_id,
       CAST(NULL AS INTEGER)     AS quantity,
       CAST(NULL AS INTEGER)     AS provider_id,
       visit_occurrence_id       AS visit_occurrence_id,
       CAST(NULL AS INTEGER)     AS visit_detail_id,
       path                      AS procedure_source_value,
       CAST(NULL AS INTEGER)     AS procedure_source_concept_id,
       CAST(NULL AS VARCHAR(50)) AS modifier_source_value,
       NULL                      AS src_table_id,
       NULL                      AS src_person_id,
       NULL                      AS src_visit_occurrence_id,
       CAST(NULL AS BIGINT)      AS src_visit_detail_id,
       c.src_name                AS src_name
FROM msft_challenge_80.waveform_registry c
         LEFT JOIN msft_challenge_80.visit_occurrence v
                   ON c.person::bigint = v.person_id::bigint
WHERE C.start_date:: TIMESTAMP BETWEEN visit_start_date - INTERVAL '1' DAY
  AND visit_end_date + INTERVAL '1' DAY;

INSERT INTO msft_challenge_80.procedure_occurrence
SELECT row_number()                 over (ORDER BY person) + (SELECT MAX(procedure_occurrence_id) FROM msft_challenge_80.procedure_occurrence) AS procedure_occurrence_id,
        person::bigint AS person_id,
        CAST(4141651 AS INTEGER) AS procedure_concept_id, -- Measuring and Monitoring Procedure
       start_date::date AS procedure_date,
       start_date::timestamp AS procedure_datetime,
       CAST(NULL AS DATE) AS procedure_end_date,
       CAST(NULL AS TIMESTAMP)   AS procedure_end_datetime,
       CAST(32880 AS INTEGER)    AS procedure_type_concept_id,
       CAST(NULL AS INTEGER)     AS modifier_concept_id,
       CAST(NULL AS INTEGER)     AS quantity,
       CAST(NULL AS INTEGER)     AS provider_id,
       NULL                      AS visit_occurrence_id,
       CAST(NULL AS INTEGER)     AS visit_detail_id,
       path                      AS procedure_source_value,
       CAST(NULL AS INTEGER)     AS procedure_source_concept_id,
       CAST(NULL AS VARCHAR(50)) AS modifier_source_value,
       NULL                      AS src_table_id,
       NULL                      AS src_person_id,
       NULL                      AS src_visit_occurrence_id,
       CAST(NULL AS BIGINT)      AS src_visit_detail_id,
       c.src_name                AS src_name
FROM msft_challenge_80.waveform_registry c
WHERE PATH NOT IN (SELECT procedure_source_value
    FROM msft_challenge_80.procedure_occurrence
    WHERE procedure_concept_id = 4141651);

