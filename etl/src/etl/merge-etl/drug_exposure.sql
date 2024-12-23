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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'columbia') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'columbia') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'duke') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'duke') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'emory') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'emory') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mgh') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mgh') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mit') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mit') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mayo') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mayo') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'nationwide') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'nationwide') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'newmexico') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'newmexico') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucla') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucsf') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucsf') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucsf') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'florida') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'florida') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'pittsburgh') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'pittsburgh') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'virginia') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'virginia') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'seattle') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'seattle') vdm
            ON vdm.old_id = de.visit_occurrence_id
        UNION
        SELECT
            drug_exposure_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'tufts' AS src_name,
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
            tufts.drug_exposure de
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'tufts') pm
                ON pm.old_id = de.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'tufts') vom
            ON vom.old_id = de.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'tufts') vdm
            ON vdm.old_id = de.visit_occurrence_id
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
