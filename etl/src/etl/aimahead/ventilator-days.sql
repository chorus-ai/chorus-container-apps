WITH visit_calc AS (
                       SELECT (visit_end_date - visit_start_date) + 1 AS visit_days,
                              visit_occurrence_id
                       FROM omopcdm.visit_occurrence
                   ),
     meas_calc AS (
                       SELECT (MAX(measurement_date) - MIN(measurement_date)) + 1 AS vent_days,
                              MAX(measurement_date)                               AS derived_date,
                              a.person_id,
                              b.visit_days,
                              b.visit_occurrence_id
                       FROM (
                                SELECT measurement_date, person_id, visit_occurrence_id
                                FROM omopcdm.measurement
                                WHERE measurement_concept_id IN (
                                                                    SELECT concept_id
                                                                    FROM public.vent_all
                                                                    WHERE domain_id = 'Measurement'
                                                                )
                            ) a
                                INNER JOIN visit_calc b
                                           ON a.visit_occurrence_id = b.visit_occurrence_id
                       GROUP BY a.person_id,
                                b.visit_occurrence_id,
                                b.visit_days
                   ),
     person_group AS (
                       SELECT person_id,
                              SUM(vent_days)                             AS days_on_ventilator,
                              SUM(visit_days)                            AS days_in_hospital,
                              MAX(derived_date)                          AS derived_date,
                              string_agg(visit_occurrence_id::text, '|') AS visit_ids
                       FROM meas_calc
                       GROUP BY person_id
                   )
INSERT
INTO aimahead (
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name,
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
    measurement_source_value,
    measurement_source_concept_id,
    unit_source_value,
    unit_source_concept_id,
    value_source_value,
    measurement_event_id,
    meas_event_field_concept_id
)

SELECT NULL                             AS src_table_id,
       NULL                             AS src_person_id,
       NULL                             AS src_visit_occurrence_id,
       NULL                             AS src_visit_detail_id,
       NULL                             AS src_name,
       row_number()                        over () + (SELECT COUNT(*) FROM aimahead.measurement) AS measurement_id,
       person_id AS person_id,
       44786857                         AS measurement_concept_id, -- days on ventilator
       derived_date::date AS measurement_date, derived_date::timestamp AS measurement_datetime, NULL AS measurement_time,
       32880                            AS measurement_type_concept_id,
       NULL                                operator_concept_id,
       days_on_ventilator               AS value_as_number,
       NULL                                value_as_concept_id,
       8512                             AS unit_concept_id,
       days_on_ventilator               AS range_low,
       days_in_hospital                 AS range_high,
       NULL                             AS visit_occurrence_id,
       NULL                             AS visit_detail_id,
       concat('Visit Ids: ', visit_ids) AS measurement_source_value,
       NULL                             AS measurement_source_concept_id,
       'Days'                           AS unit_source_value,
       NULL                             AS unit_source_concept_id,
       concat(days_on_ventilator::text, ' days on vent out of ', days_in_hospital,
              ' total visit days')      AS value_source_value,
       NULL                             AS measurement_event_id,
       NULL                             AS meas_event_field_concept_id

FROM person_group;