WITH device_exposure_joined AS (
                                   SELECT NULL::integer  AS src_table_id,
                                          NULL::integer           AS src_person_id,
                                          NULL::integer AS src_visit_occurrence_id,
                                          NULL::integer     AS src_visit_detail_id,
                                          sk.s_key AS src_name,
                                          device_exposure_id,
                                          person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          NULL AS unique_device_id,
                                          NULL AS production_id,
                                          quantity,
                                          visit_occurrence_id,
                                          visit_detail_id,
                                          NULL AS device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          NULL AS unit_source_value,
                                          unit_source_concept_id
                                   FROM aimahead.device_exposure de
                                   JOIN persist.source_key sk ON src_name = sk.s_name
                                       WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
                                       AND device_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
                               )
INSERT
INTO
    aimahead_60.device_exposure
SELECT device_exposure_id,
       person_id,
       device_concept_id,
       device_exposure_start_date,
       device_exposure_start_datetime,
       device_exposure_end_date,
       device_exposure_end_datetime,
       device_type_concept_id,
       unique_device_id,
       production_id,
       quantity,
       NULL AS      provider_id,
       visit_occurrence_id,
       visit_detail_id,
       device_source_value,
       device_source_concept_id,
       unit_concept_id,
       unit_source_value,
       unit_source_concept_id,
       src_table_id,
       src_person_id,
       src_visit_occurrence_id,
       src_visit_detail_id,
       src_name
FROM device_exposure_joined;
