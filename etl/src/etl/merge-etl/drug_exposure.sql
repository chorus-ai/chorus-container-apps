WITH
    drug_exposure_joined AS (
        SELECT
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'columbia' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            columbia.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'duke' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            duke.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'emory' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            emory.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mgh' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            mgh.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mit' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            mit.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mayo' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            mayo.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'nationwide' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            nationwide.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'newmexico' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            newmexico.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucla' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            ucla.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucsf' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            ucsf.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'florida' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            florida.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'pittsburgh' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            pittsburgh.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'virginia' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            virginia.drug_exposure de
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
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'seattle' AS src_name,
            pm.new_id AS person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            sig,
            route_concept_id,
            lot_number,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            drug_source_value,
            drug_source_concept_id,
            route_source_value,
            dose_unit_source_value
        FROM
            seattle.drug_exposure de
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
    drug_exposure
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) AS drug_exposure_id,
    person_id,
    drug_concept_id,
    drug_exposure_start_date,
    drug_exposure_start_datetime,
    drug_exposure_end_date,
    drug_exposure_end_datetime,
    verbatim_end_date,
    drug_type_concept_id,
    stop_reason,
    refills,
    quantity,
    days_supply,
    sig,
    route_concept_id,
    lot_number,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    drug_source_value,
    drug_source_concept_id,
    route_source_value,
    dose_unit_source_value,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    drug_exposure_joined;
