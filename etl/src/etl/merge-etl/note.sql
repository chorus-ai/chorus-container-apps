WITH
    note_joined AS (
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'columbia' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            columbia.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'columbia'
            AND nm.source_name = 'columbia'
            AND vom.source_name = 'columbia'
            AND vdm.source_name = 'columbia'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'duke' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            duke.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'duke'
            AND nm.source_name = 'duke'
            AND vom.source_name = 'duke'
            AND vdm.source_name = 'duke'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'emory' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            emory.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'emory'
            AND nm.source_name = 'emory'
            AND vom.source_name = 'emory'
            AND vdm.source_name = 'emory'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mgh' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            mgh.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'mgh'
            AND nm.source_name = 'mgh'
            AND vom.source_name = 'mgh'
            AND vdm.source_name = 'mgh'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mit' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            mit.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'mit'
            AND nm.source_name = 'mit'
            AND vom.source_name = 'mit'
            AND vdm.source_name = 'mit'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mayo' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            mayo.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'mayo'
            AND nm.source_name = 'mayo'
            AND vom.source_name = 'mayo'
            AND vdm.source_name = 'mayo'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'nationwide' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            nationwide.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'nationwide'
            AND nm.source_name = 'nationwide'
            AND vom.source_name = 'nationwide'
            AND vdm.source_name = 'nationwide'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'newmexico' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            newmexico.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'newmexico'
            AND nm.source_name = 'newmexico'
            AND vom.source_name = 'newmexico'
            AND vdm.source_name = 'newmexico'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucla' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            ucla.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'ucla'
            AND nm.source_name = 'ucla'
            AND vom.source_name = 'ucla'
            AND vdm.source_name = 'ucla'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucsf' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            ucsf.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'ucsf'
            AND nm.source_name = 'ucsf'
            AND vom.source_name = 'ucsf'
            AND vdm.source_name = 'ucsf'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'florida' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            florida.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'florida'
            AND nm.source_name = 'florida'
            AND vom.source_name = 'florida'
            AND vdm.source_name = 'florida'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'pittsburgh' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            pittsburgh.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'pittsburgh'
            AND nm.source_name = 'pittsburgh'
            AND vom.source_name = 'pittsburgh'
            AND vdm.source_name = 'pittsburgh'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'virginia' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            virginia.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'virginia'
            AND nm.source_name = 'virginia'
            AND vom.source_name = 'virginia'
            AND vdm.source_name = 'virginia'
        UNION
        SELECT
            note_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'seattle' AS src_name,
            nm.new_id AS note_id,
            pm.new_id AS person_id,
            note_date,
            note_datetime,
            note_type_concept_id,
            note_class_concept_id,
            note_title,
            note_text,
            encoding_concept_id,
            language_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            note_source_value,
            note_event_id,
            note_event_field_concept_id
        FROM
            seattle.note n
        INNER JOIN person_map pm
                ON pm.old_id = n.person_id
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = n.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = n.visit_occurrence_id
        WHERE pm.source_name = 'seattle'
            AND nm.source_name = 'seattle'
            AND vom.source_name = 'seattle'
            AND vdm.source_name = 'seattle'
    )
INSERT INTO
    note
SELECT
    note_id,
    person_id,
    note_date,
    note_datetime,
    note_type_concept_id,
    note_class_concept_id,
    note_title,
    note_text,
    encoding_concept_id,
    language_concept_id,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    note_source_value,
    note_event_id,
    note_event_field_concept_id,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    note_joined;
