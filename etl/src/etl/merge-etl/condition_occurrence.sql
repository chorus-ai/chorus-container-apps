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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'columbia') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'columbia') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'duke') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'duke') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'emory') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'emory') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mgh') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mgh') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mit') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mit') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mayo') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mayo') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'nationwide') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'nationwide') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'newmexico') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'newmexico') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucla') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucsf') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucsf') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucsf') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'florida') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'florida') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'pittsburgh') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'pittsburgh') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'virginia') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'virginia') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'seattle') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'seattle') vdm
                ON vdm.old_id = co.visit_occurrence_id
        UNION
        SELECT
            condition_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'tufts' AS src_name,
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
            tufts.condition_occurrence co
            INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'tufts') pm
                ON pm.old_id = co.person_id
            LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'tufts') vom
                ON vom.old_id = co.visit_occurrence_id
            LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'tufts') vdm
                ON vdm.old_id = co.visit_occurrence_id
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
    
