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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'columbia') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'columbia') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'columbia') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'columbia') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'duke') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'duke') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'duke') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'duke') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'emory') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'emory') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'emory') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'emory') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mgh') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mgh') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mgh') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mgh') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mit') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mit') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mit') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mit') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mayo') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mayo') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mayo') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mayo') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'nationwide') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'nationwide') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'nationwide') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'nationwide') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'newmexico') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'newmexico') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'newmexico') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'newmexico') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucla') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucsf') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucsf') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucsf') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucsf') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucsf') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'florida') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'florida') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'florida') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'florida') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'pittsburgh') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'pittsburgh') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'pittsburgh') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'pittsburgh') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'virginia') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'virginia') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'virginia') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'virginia') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'seattle') pm
                ON pm.old_id = v.person_id
        INNER JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vom
            ON vom.old_id = v.visit_occurrence_id
        INNER JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'seattle') vdm
            ON vdm.old_id = v.visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'seattle') vdm2
            ON vdm2.old_id = v.preceding_visit_detail_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'seattle') vdm3
            ON vdm3.old_id = v.parent_visit_detail_id
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
    NULL AS provider_id,
    NULL AS care_site_id,
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
