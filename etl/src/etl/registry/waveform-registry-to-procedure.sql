INSERT INTO omopcdm.procedure_occurrence
                SELECT
                    file_id AS procedure_occurrence_id,
                    person_id AS person_id,
                    CAST(4141651 AS integer) AS procedure_concept_id, -- Measuring and Monitoring Procedure
                    file_datetime::date AS procedure_date,
                    file_datetime AS procedure_datetime,
                    CAST(NULL AS DATE) AS procedure_end_date,
                    CAST(NULL AS TIMESTAMP) AS procedure_end_datetime,
                    CAST(32880 AS integer) AS procedure_type_concept_id,
                    CAST(NULL AS integer) AS modifier_concept_id,
                    CAST(NULL AS integer) AS quantity,
                    CAST(NULL AS integer) AS provider_id,
                    visit_occurrence_id AS visit_occurrence_id,
                    CAST(NULL AS integer) AS visit_detail_id,
                    CONCAT(src_name, ': ', trg_file) AS procedure_source_value,
                    CAST(NULL AS integer) AS procedure_source_concept_id,
                    CAST(NULL AS VARCHAR(50)) AS modifier_source_value,
                    src_file_id AS src_table_id,
                    src_person_id AS src_person_id,
                    src_visit_occurrence_id AS src_visit_occurrence_id,
                    CAST(NULL AS bigint) AS src_visit_detail_id,
                    src_name AS src_name
                FROM
                    public.waveform_reg;

