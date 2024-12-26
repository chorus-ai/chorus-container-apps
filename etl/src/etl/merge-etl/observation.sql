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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'columbia') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'columbia') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'duke') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'duke') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'emory') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'emory') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mgh') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mgh') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mit') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mit') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mayo') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mayo') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'nationwide') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'nationwide') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'newmexico') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'newmexico') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucla') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucsf') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucsf') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucsf') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'florida') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'florida') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'pittsburgh') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'pittsburgh') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'virginia') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'virginia') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
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
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'seattle') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'seattle') vdm
            ON vdm.old_id = o.visit_occurrence_id
        )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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


WITH
    observation_joined AS (
        SELECT
            observation_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'tufts' AS src_name,
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
            tufts.observation o
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'tufts') pm
                ON pm.old_id = o.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'tufts') vom
            ON vom.old_id = o.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'tufts') vdm
            ON vdm.old_id = o.visit_occurrence_id
    )
INSERT INTO
    observation
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) + (SELECT count(*) FROM observation) AS observation_id,
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
