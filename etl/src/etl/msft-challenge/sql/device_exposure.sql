WITH device_exposure_joined AS (
                                   SELECT NULL::integer  AS src_table_id,
                                          NULL::integer           AS src_person_id,
                                          NULL::integer AS src_visit_occurrence_id,
                                          NULL::integer     AS src_visit_detail_id,
                                          CASE WHEN src_name = 'mgh' THEN '1'
                                                   WHEN src_name = 'mit' THEN '2'
                                                   WHEN src_name = 'nationwide' THEN '3'
                                                   WHEN src_name = 'pittsburgh' THEN '4'
                                                   WHEN src_name = 'seattle' THEN '5'
                                              END AS src_name,
                                          device_exposure_id,
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
                                          visit_occurrence_id,
                                          visit_detail_id,
                                          NULL AS device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM msft_challenge.device_exposure de
                                       WHERE person_id IN (SELECT person_id FROM msft_challenge_80.person)
                               )
INSERT
INTO
    msft_challenge_80.device_exposure
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
