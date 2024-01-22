WITH
    device_exposure_joined AS (
        SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'columbia' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            columbia.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'columbia'
            AND vom.source_name = 'columbia'
            AND vdm.source_name = 'columbia'
        UNION
        SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'duke' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            duke.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'duke'
            AND vom.source_name = 'duke'
            AND vdm.source_name = 'duke'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'emory' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            emory.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'emory'
            AND vom.source_name = 'emory'
            AND vdm.source_name = 'emory'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mgh' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            mgh.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'mgh'
            AND vom.source_name = 'mgh'
            AND vdm.source_name = 'mgh'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mit' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            mit.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'mit'
            AND vom.source_name = 'mit'
            AND vdm.source_name = 'mit'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mayo' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            mayo.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'mayo'
            AND vom.source_name = 'mayo'
            AND vdm.source_name = 'mayo'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'nationwide' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            nationwide.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'nationwide'
            AND vom.source_name = 'nationwide'
            AND vdm.source_name = 'nationwide'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'newmexico' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            newmexico.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'newmexico'
            AND vom.source_name = 'newmexico'
            AND vdm.source_name = 'newmexico'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucla' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            ucla.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'ucla'
            AND vom.source_name = 'ucla'
            AND vdm.source_name = 'ucla'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucsf' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            ucsf.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'ucsf'
            AND vom.source_name = 'ucsf'
            AND vdm.source_name = 'ucsf'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'florida' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            florida.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'florida'
            AND vom.source_name = 'florida'
            AND vdm.source_name = 'florida'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'pittsburgh' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            pittsburgh.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'pittsburgh'
            AND vom.source_name = 'pittsburgh'
            AND vdm.source_name = 'pittsburgh'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'virginia' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            virginia.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'virginia'
            AND vom.source_name = 'virginia'
            AND vdm.source_name = 'virginia'
    UNION
    SELECT
            device_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'seattle' AS src_name,
            pm.new_id AS person_id,
            device_concept_id,
            device_exposure_start_date,
            device_exposure_start_datetime,
            device_exposure_end_date,
            device_exposure_end_datetime,
            device_type_concept_id,
            unique_device_id,
            production_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            device_source_value,
            device_source_concept_id,
            unit_concept_id,
            unit_source_value,
            unit_source_concept_id
        FROM
            seattle.device_exposure de
        INNER JOIN person_map pm
                ON pm.old_id = de.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = de.visit_occurrence_id
        WHERE pm.source_name = 'seattle'
            AND vom.source_name = 'seattle'
            AND vdm.source_name = 'seattle'
    )
INSERT INTO
    device_exposure
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) AS device_exposure_id,
    person_id,
    device_concept_id,
    device_exposure_start_date,
    device_exposure_start_datetime,
    device_exposure_end_date,
    device_exposure_end_datetime,
    device_type_concept_id,
    unique_device_id,
    production_id,
    quantity,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    device_source_value,
    device_source_concept_id,
    unit_concept_id,
    unit_source_value,
    unit_source_concept_id,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    device_exposure_joined;
