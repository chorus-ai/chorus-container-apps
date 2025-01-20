WITH
    measurement_joined AS (
        SELECT
            NULL::integer AS src_table_id,
            NULL::integer AS src_person_id,
            NULL::integer AS src_visit_occurrence_id,
            NULL::integer AS src_visit_detail_id,
            sk.s_key AS src_name,
            measurement_id,
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
            visit_occurrence_id,
            visit_detail_id,
            NULL AS measurement_source_value,
            measurement_source_concept_id,
            NULL AS unit_source_value,
            unit_source_concept_id,
            NULL AS value_source_value,
            measurement_event_id,
            meas_event_field_concept_id
        FROM aimahead.measurement m
        JOIN persist.source_key sk ON m.src_name = sk.s_name
        WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
        AND measurement_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
    )
INSERT INTO
    aimahead_60.measurement
SELECT
    measurement_id,
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
