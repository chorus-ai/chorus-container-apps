WITH
    visit_occurrence_joined AS (
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'columbia' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            columbia.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'columbia'
            AND vom.source_name = 'columbia'
            AND vom2.source_name = 'columbia'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'duke' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            duke.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'duke'
            AND vom.source_name = 'duke'
            AND vom2.source_name = 'duke'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'emory' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            emory.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'emory'
            AND vom.source_name = 'emory'
            AND vom2.source_name = 'emory'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'mgh' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            mgh.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'mgh'
            AND vom.source_name = 'mgh'
            AND vom2.source_name = 'mgh'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'mit' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            mit.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'mit'
            AND vom.source_name = 'mit'
            AND vom2.source_name = 'mit'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'mayo' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            mayo.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'mayo'
            AND vom.source_name = 'mayo'
            AND vom2.source_name = 'mayo'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'nationwide' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            nationwide.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'nationwide'
            AND vom.source_name = 'nationwide'
            AND vom2.source_name = 'nationwide'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'newmexico' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            newmexico.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'newmexico'
            AND vom.source_name = 'newmexico'
            AND vom2.source_name = 'newmexico'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'ucla' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            ucla.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'ucla'
            AND vom.source_name = 'ucla'
            AND vom2.source_name = 'ucla'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'ucsf' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            ucsf.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'ucsf'
            AND vom.source_name = 'ucsf'
            AND vom2.source_name = 'ucsf'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'florida' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            florida.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'florida'
            AND vom.source_name = 'florida'
            AND vom2.source_name = 'florida'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'pittsburgh' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            pittsburgh.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'pittsburgh'
            AND vom.source_name = 'pittsburgh'
            AND vom2.source_name = 'pittsburgh'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'virginia' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            virginia.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'virginia'
            AND vom.source_name = 'virginia'
            AND vom2.source_name = 'virginia'
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'seattle' AS src_name,
            vom.new_id AS visit_occurrence_id,
            pm.new_id AS person_id,
            visit_concept_id,
            visit_start_date,
            visit_start_datetime,
            visit_end_date,
            visit_end_datetime,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            admitted_from_concept_id,
            admitted_from_source_value,
            discharged_to_concept_id,
            discharged_to_source_value,
            vom2.new_id AS preceding_visit_occurrence_id
        FROM
            seattle.visit_occurrence v
        INNER JOIN person_map pm
                ON pm.old_id = v.person_id
        INNER JOIN visit_occurrence_map vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN visit_occurrence_map vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        WHERE pm.source_name = 'seattle'
            AND vom.source_name = 'seattle'
            AND vom2.source_name = 'seattle'
        
    )
INSERT INTO
    visit_occurrence
SELECT
    visit_occurrence_id,
    person_id,
    visit_concept_id,
    visit_start_date,
    visit_start_datetime,
    visit_end_date,
    visit_end_datetime,
    visit_type_concept_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    visit_source_value,
    visit_source_concept_id,
    admitted_from_concept_id,
    admitted_from_source_value,
    discharged_to_concept_id,
    discharged_to_source_value,
    preceding_visit_occurrence_id,
    src_person_id,
    src_visit_occurrence_id,
    src_prec_visit_occurrence_id,
    src_name
FROM
    visit_occurrence_joined;
