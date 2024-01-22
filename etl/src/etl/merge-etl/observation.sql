WITH
    observation_joined AS (
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'columbia' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            columbia.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'columbia'
            AND vom.source_name = 'columbia'
            AND vdm.source_name = 'columbia'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'duke' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            duke.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'duke'
            AND vom.source_name = 'duke'
            AND vdm.source_name = 'duke'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'emory' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            emory.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'emory'
            AND vom.source_name = 'emory'
            AND vdm.source_name = 'emory'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mgh' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            mgh.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'mgh'
            AND vom.source_name = 'mgh'
            AND vdm.source_name = 'mgh'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mit' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            mit.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'mit'
            AND vom.source_name = 'mit'
            AND vdm.source_name = 'mit'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mayo' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            mayo.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'mayo'
            AND vom.source_name = 'mayo'
            AND vdm.source_name = 'mayo'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'nationwide' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            nationwide.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'nationwide'
            AND vom.source_name = 'nationwide'
            AND vdm.source_name = 'nationwide'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'newmexico' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            newmexico.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'newmexico'
            AND vom.source_name = 'newmexico'
            AND vdm.source_name = 'newmexico'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucla' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            ucla.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'ucla'
            AND vom.source_name = 'ucla'
            AND vdm.source_name = 'ucla'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucsf' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            ucsf.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'ucsf'
            AND vom.source_name = 'ucsf'
            AND vdm.source_name = 'ucsf'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'florida' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            florida.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'florida'
            AND vom.source_name = 'florida'
            AND vdm.source_name = 'florida'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'pittsburgh' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            pittsburgh.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'pittsburgh'
            AND vom.source_name = 'pittsburgh'
            AND vdm.source_name = 'pittsburgh'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'virginia' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            virginia.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'virginia'
            AND vom.source_name = 'virginia'
            AND vdm.source_name = 'virginia'
        UNION
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'seattle' AS src_name,
            pm.new_id AS person_id,
            observation_concept_id,
            observation_date,
            observation_datetime,
            observation_type_concept_id,
            value_as_number,
            value_as_string,
            value_as_concept_id,
            qualifier_concept_id,
            unit_concept_id,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            observation_source_value,
            observation_source_concept_id,
            unit_source_value,
            qualifier_source_value,
            value_source_value,
            observation_event_id,
            obs_event_field_concept_id
        FROM
            seattle.observation o
        INNER JOIN person_map pm
                ON pm.old_id = o.person_id
        LEFT JOIN visit_occurrence_map vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN visit_detail_map vdm
            ON vdm.old_id = o.visit_occurrence_id
        WHERE pm.source_name = 'seattle'
            AND vom.source_name = 'seattle'
            AND vdm.source_name = 'seattle'
    )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) AS observation_id,
    person_id,
    observation_concept_id,
    observation_date,
    observation_datetime,
    observation_type_concept_id,
    value_as_number,
    value_as_string,
    value_as_concept_id,
    qualifier_concept_id,
    unit_concept_id,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    observation_source_value,
    observation_source_concept_id,
    unit_source_value,
    qualifier_source_value,
    value_source_value,
    observation_event_id,
    obs_event_field_concept_id,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    observation_joined;
