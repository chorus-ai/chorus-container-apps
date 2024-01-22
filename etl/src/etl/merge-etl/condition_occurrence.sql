WITH
    condition_occurrence_joined AS (
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'columbia' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            columbia.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'columbia'
                AND vom.source_name = 'columbia'
                AND vdm.source_name = 'columbia'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'duke' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            duke.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'duke'
                AND vom.source_name = 'duke'
                AND vdm.source_name = 'duke'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'emory' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            emory.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'emory'
                AND vom.source_name = 'emory'
                AND vdm.source_name = 'emory'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mgh' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            mgh.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'mgh'
                AND vom.source_name = 'mgh'
                AND vdm.source_name = 'mgh'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mit' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            mit.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'mit'
                AND vom.source_name = 'mit'
                AND vdm.source_name = 'mit'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mayo' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            mayo.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'mayo'
                AND vom.source_name = 'mayo'
                AND vdm.source_name = 'mayo'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'nationwide' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            nationwide.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'nationwide'
                AND vom.source_name = 'nationwide'
                AND vdm.source_name = 'nationwide'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'newmexico' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            newmexico.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'newmexico'
                AND vom.source_name = 'newmexico'
                AND vdm.source_name = 'newmexico'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucla' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            ucla.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'ucla'
                AND vom.source_name = 'ucla'
                AND vdm.source_name = 'ucla'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucsf' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            ucsf.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'ucsf'
                AND vom.source_name = 'ucsf'
                AND vdm.source_name = 'ucsf'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'florida' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            florida.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'florida'
                AND vom.source_name = 'florida'
                AND vdm.source_name = 'florida'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'pittsburgh' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            pittsburgh.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'pittsburgh'
                AND vom.source_name = 'pittsburgh'
                AND vdm.source_name = 'pittsburgh'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'virginia' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            virginia.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'virginia'
                AND vom.source_name = 'virginia'
                AND vdm.source_name = 'virginia'
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'seattle' AS src_name,
            pm.new_id AS person_id,
            condition_concept_id,
            condition_start_date,
            condition_start_datetime,
            condition_end_date,
            condition_end_datetime,
            condition_type_concept_id,
            condition_status_concept_id,
            stop_reason,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            condition_source_value,
            condition_source_concept_id,
            condition_status_source_value
        FROM
            seattle.condition_occurrence co
            INNER JOIN person_map pm
                ON pm.old_id = co.person_id
            LEFT JOIN visit_occurrence_map vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN visit_detail_map vdm
                ON vdm.old_id = co.visit_occurrence_id
            WHERE pm.source_name = 'seattle'
                AND vom.source_name = 'seattle'
                AND vdm.source_name = 'seattle'
    )
INSERT INTO
    condition_occurrence
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) AS condition_occurrence_id,
    person_id,
    condition_concept_id,
    condition_start_date,
    condition_start_datetime,
    condition_end_date,
    condition_end_datetime,
    condition_type_concept_id,
    condition_status_concept_id,
    stop_reason,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    condition_source_value,
    condition_source_concept_id,
    condition_status_source_value,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    condition_occurrence_joined;
    
