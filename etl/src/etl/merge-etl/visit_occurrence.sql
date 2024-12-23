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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'columbia') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'duke') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'emory') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mgh') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mit') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mayo') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'nationwide') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'newmexico') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucla') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucsf') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucsf') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucsf') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'florida') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'pittsburgh') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'virginia') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'seattle') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
        UNION
        SELECT
            visit_occurrence_id AS src_visit_occurrence_id,
            person_id AS src_person_id,
            preceding_visit_occurrence_id AS src_prec_visit_occurrence_id,
            'tufts' AS src_name,
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
            tufts.visit_occurrence v
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'tufts') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'tufts') vom
            ON vom.old_id = v.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'tufts') vom2
            ON vom2.old_id = v.preceding_visit_occurrence_id
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
