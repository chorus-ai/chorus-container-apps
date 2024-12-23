WITH
    measurement_joined AS (
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'columbia' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            columbia.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'columbia') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'columbia') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'duke' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            duke.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'duke') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'duke') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'emory' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            emory.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'emory') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'emory') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mgh' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            mgh.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mgh') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mgh') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mit' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            mit.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mit') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mit') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'mayo' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            mayo.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'mayo') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'mayo') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'nationwide' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            nationwide.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'nationwide') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'nationwide') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'newmexico' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            newmexico.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'newmexico') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'newmexico') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucla' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            ucla.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucla') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucla') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'ucsf' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            ucsf.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'ucsf') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucsf') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'ucsf') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'florida' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            florida.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'florida') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'florida') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'pittsburgh' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            pittsburgh.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'pittsburgh') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'pittsburgh') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'virginia' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            virginia.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'virginia') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'virginia') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'seattle' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            seattle.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'seattle') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'seattle') vdm
            ON vdm.old_id = m.visit_occurrence_id
        UNION
        SELECT
            measurement_id AS src_table_id,
            person_id AS src_person_id,
            visit_occurrence_id AS src_visit_occurrence_id,
            visit_detail_id AS src_visit_detail_id,
            'tufts' AS src_name,
            pm.new_id AS person_id,
            measurement_concept_id,
            measurement_date,
            measurement_datetime,
            measurement_time,
            measurement_type_concept_id,
            operator_concept_id,
            value_as_number,
            value_as_concept_id,
            unit_concept_id,
            range_low,
            range_high,
            vom.new_id AS visit_occurrence_id,
            vdm.new_id AS visit_detail_id,
            measurement_source_value,
            measurement_source_concept_id,
            unit_source_value,
            unit_source_concept_id,
            value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM
            tufts.measurement m
        INNER JOIN (SELECT * FROM persist.person_map WHERE source_name = 'tufts') pm
                ON pm.old_id = m.person_id
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'tufts') vom
            ON vom.old_id = m.visit_occurrence_id
        LEFT JOIN (SELECT * FROM persist.visit_detail_map WHERE source_name = 'tufts') vdm
            ON vdm.old_id = m.visit_occurrence_id
    )
INSERT INTO
    measurement
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) AS measurement_id,
    person_id,
    measurement_concept_id,
    measurement_date,
    measurement_datetime,
    measurement_time,
    measurement_type_concept_id,
    operator_concept_id,
    value_as_number,
    value_as_concept_id,
    unit_concept_id,
    range_low,
    range_high,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    measurement_source_value,
    measurement_source_concept_id,
    unit_source_value,
    unit_source_concept_id,
    value_source_value,
    measurement_event_id,
    meas_event_field_concept_id,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    measurement_joined;
