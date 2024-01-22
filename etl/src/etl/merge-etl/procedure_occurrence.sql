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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'columbia'
            AND vom.source_name = 'columbia'
            AND vdm.source_name = 'columbia'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'duke'
            AND vom.source_name = 'duke'
            AND vdm.source_name = 'duke'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'emory'
            AND vom.source_name = 'emory'
            AND vdm.source_name = 'emory'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'mgh'
            AND vom.source_name = 'mgh'
            AND vdm.source_name = 'mgh'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'mit'
            AND vom.source_name = 'mit'
            AND vdm.source_name = 'mit'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'mayo'
            AND vom.source_name = 'mayo'
            AND vdm.source_name = 'mayo'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'nationwide'
            AND vom.source_name = 'nationwide'
            AND vdm.source_name = 'nationwide'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'newmexico'
            AND vom.source_name = 'newmexico'
            AND vdm.source_name = 'newmexico'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'ucla'
            AND vom.source_name = 'ucla'
            AND vdm.source_name = 'ucla'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'ucsf'
            AND vom.source_name = 'ucsf'
            AND vdm.source_name = 'ucsf'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'florida'
            AND vom.source_name = 'florida'
            AND vdm.source_name = 'florida'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'pittsburgh'
            AND vom.source_name = 'pittsburgh'
            AND vdm.source_name = 'pittsburgh'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'virginia'
            AND vom.source_name = 'virginia'
            AND vdm.source_name = 'virginia'
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
        INNER JOIN person_map pm
                ON pm.old_id = p.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = p.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = p.visit_occurrence_id
        WHERE pm.source_name = 'seattle'
            AND vom.source_name = 'seattle'
            AND vdm.source_name = 'seattle'
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
