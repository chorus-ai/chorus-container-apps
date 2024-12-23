WITH
    procedure_occurrence_joined AS (
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'columbia' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            columbia.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'columbia') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'columbia') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'duke' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            duke.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'duke') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'duke') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'emory' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            emory.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'emory') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'emory') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mgh' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            mgh.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mgh') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mgh') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mit' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            mit.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mit') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mit') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mayo' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            mayo.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mayo') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mayo') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'nationwide' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            nationwide.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'nationwide') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'nationwide') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'newmexico' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            newmexico.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'newmexico') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'newmexico') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucla' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            ucla.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucla') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucsf' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            ucsf.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucla') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'florida' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            florida.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'florida') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'florida') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'pittsburgh' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            pittsburgh.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'pittsburgh') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'pittsburgh') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'virginia' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            virginia.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'virginia') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'virginia') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'seattle' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            seattle.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'seattle') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'seattle') vdm
            ON vdm.old_id = p.visit_occurrence_id
        UNION
        SELECT
            procedure_occurrence_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'tufts' AS src_name,
            pm.new_id AS person_id,
            procedure_concept_id,
            procedure_date,
            procedure_datetime,
            procedure_end_date,
            procedure_end_datetime,
            procedure_type_concept_id,
            modifier_concept_id,
            quantity,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            procedure_source_value,
            procedure_source_concept_id,
            modifier_source_value
        FROM
            tufts.procedure_occurrence p
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'tufts') pm
                ON pm.old_id = p.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'tufts') vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'tufts') vdm
            ON vdm.old_id = p.visit_occurrence_id
    )
INSERT INTO
    procedure_occurrence
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) AS procedure_occurrence_id,
    person_id,
    procedure_concept_id,
    procedure_date,
    procedure_datetime,
    procedure_end_date,
    procedure_end_datetime,
    procedure_type_concept_id,
    modifier_concept_id,
    quantity,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    procedure_source_value,
    procedure_source_concept_id,
    modifier_source_value,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    procedure_occurrence_joined;
