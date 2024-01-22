WITH
    visit_detail_joined AS (
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'columbia' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            columbia.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'columbia'
            AND vom.source_name = 'columbia'
            AND vdm.source_name = 'columbia'
            AND vdm2.source_name = 'columbia'
            AND vdm3.source_name = 'columbia'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'duke' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            duke.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'duke'
            AND vom.source_name = 'duke'
            AND vdm.source_name = 'duke'
            AND vdm2.source_name = 'duke'
            AND vdm3.source_name = 'duke'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'emory' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            emory.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'emory'
            AND vom.source_name = 'emory'
            AND vdm.source_name = 'emory'
            AND vdm2.source_name = 'emory'
            AND vdm3.source_name = 'emory'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'mgh' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            mgh.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'mgh'
            AND vom.source_name = 'mgh'
            AND vdm.source_name = 'mgh'
            AND vdm2.source_name = 'mgh'
            AND vdm3.source_name = 'mgh'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'mit' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            mit.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'mit'
            AND vom.source_name = 'mit'
            AND vdm.source_name = 'mit'
            AND vdm2.source_name = 'mit'
            AND vdm3.source_name = 'mit'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'mayo' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            mayo.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'mayo'
            AND vom.source_name = 'mayo'
            AND vdm.source_name = 'mayo'
            AND vdm2.source_name = 'mayo'
            AND vdm3.source_name = 'mayo'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'nationwide' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            nationwide.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'nationwide'
            AND vom.source_name = 'nationwide'
            AND vdm.source_name = 'nationwide'
            AND vdm2.source_name = 'nationwide'
            AND vdm3.source_name = 'nationwide'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'newmexico' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            newmexico.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'newmexico'
            AND vom.source_name = 'newmexico'
            AND vdm.source_name = 'newmexico'
            AND vdm2.source_name = 'newmexico'
            AND vdm3.source_name = 'newmexico'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'ucla' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            ucla.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'ucla'
            AND vom.source_name = 'ucla'
            AND vdm.source_name = 'ucla'
            AND vdm2.source_name = 'ucla'
            AND vdm3.source_name = 'ucla'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'ucsf' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            ucsf.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'ucsf'
            AND vom.source_name = 'ucsf'
            AND vdm.source_name = 'ucsf'
            AND vdm2.source_name = 'ucsf'
            AND vdm3.source_name = 'ucsf'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'florida' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            florida.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'florida'
            AND vom.source_name = 'florida'
            AND vdm.source_name = 'florida'
            AND vdm2.source_name = 'florida'
            AND vdm3.source_name = 'florida'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'pittsburgh' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            pittsburgh.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'pittsburgh'
            AND vom.source_name = 'pittsburgh'
            AND vdm.source_name = 'pittsburgh'
            AND vdm2.source_name = 'pittsburgh'
            AND vdm3.source_name = 'pittsburgh'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'virginia' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            virginia.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'virginia'
            AND vom.source_name = 'virginia'
            AND vdm.source_name = 'virginia'
            AND vdm2.source_name = 'virginia'
            AND vdm3.source_name = 'virginia'
        UNION
        SELECT
            visit_detail_id AS src_visit_detail_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_detail_id AS src_prec_visit_detail_id,
            parent_visit_detail_id AS src_parent_visit_detail_id,
            'seattle' AS src_name,
            vdm.new_id AS visit_detail_id,
            pm.new_id AS person_id,
            visit_detail_concept_id,
            visit_detail_start_date,
            visit_detail_start_datetime,
            visit_detail_end_date,
            visit_detail_end_datetime,
            visit_detail_type_concept_id,
            visit_detail_source_value,
            visit_detail_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vdm2.new_id AS preceding_visit_detail_id,
            vdm3.new_id AS parent_visit_detail_id,
            vom.new_id AS visit_occurrence_id
        FROM
            seattle.visit_detail v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN visit_detail_map vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN visit_detail_map vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN visit_detail_map vdm3
            ON vdm2.old_id = v.parent_visit_detail_id
        WHERE pm.source_name = 'seattle'
            AND vom.source_name = 'seattle'
            AND vdm.source_name = 'seattle'
            AND vdm2.source_name = 'seattle'
            AND vdm3.source_name = 'seattle'
    )
INSERT INTO
visit_detail
SELECT
    visit_detail_id,
    person_id,
    visit_detail_concept_id,
    visit_detail_start_date,
    visit_detail_start_datetime,
    visit_detail_end_date,
    visit_detail_end_datetime,
    visit_detail_type_concept_id,
    provider_id,
    care_site_id,
    visit_detail_source_value,
    visit_detail_source_concept_id,
    admitted_from_concept_id,
    admitted_from_source_value,
    discharged_to_concept_id,
    discharged_to_source_value,
    preceding_visit_detail_id,
    parent_visit_detail_id,
    visit_occurrence_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_prec_visit_detail_id,
    src_parent_visit_detail_id,
    src_name
FROM
    visit_detail_joined;
