WITH device_exposure_joined AS (
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'columbia'          AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM columbia.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'columbia'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'columbia'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'columbia'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'duke'              AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM duke.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'duke'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'duke'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'duke'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'emory'             AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM emory.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'emory'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'emory'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'emory'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'mgh'               AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM mgh.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'mgh'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'mgh'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'mgh'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'mit'               AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM mit.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'mit'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'mit'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'mit'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'mayo'              AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM mayo.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'mayo'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'mayo'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'mayo'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'nationwide'        AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM nationwide.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'nationwide'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'nationwide'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'nationwide'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'newmexico'         AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM newmexico.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'newmexico'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'newmexico'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'newmexico'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'ucla'              AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM ucla.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'ucla'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'ucla'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'ucla'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'ucsf'              AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM ucsf.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'ucsf'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'ucsf'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'ucsf'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'florida'           AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM florida.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'florida'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'florida'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'florida'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'pittsburgh'        AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM pittsburgh.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'pittsburgh'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'pittsburgh'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'pittsburgh'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'virginia'          AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM virginia.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'virginia'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'virginia'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'virginia'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                                   UNION
                                   SELECT device_exposure_id  AS src_table_id,
                                          person_id           AS src_person_id,
                                          visit_occurrence_id AS src_visit_occurrence_id,
                                          visit_detail_id     AS src_visit_detail_id,
                                          'seattle'           AS src_name,
                                          pm.new_id           AS person_id,
                                          device_concept_id,
                                          device_exposure_start_date,
                                          device_exposure_start_datetime,
                                          device_exposure_end_date,
                                          device_exposure_end_datetime,
                                          device_type_concept_id,
                                          unique_device_id,
                                          production_id,
                                          quantity,
                                          vom.new_id          AS visit_occurrence_id,
                                          vdm.new_id          AS visit_detail_id,
                                          device_source_value,
                                          device_source_concept_id,
                                          unit_concept_id,
                                          unit_source_value,
                                          unit_source_concept_id
                                   FROM seattle.device_exposure de
                                            INNER JOIN (
                                                           SELECT *
                                                           FROM persist.person_map
                                                           WHERE source_name = 'seattle'
                                                       ) pm
                                                       ON pm.old_id = de.person_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_occurrence_map
                                                          WHERE source_name = 'seattle'
                                                      ) vom
                                                      ON vom.old_id = de.visit_occurrence_id
                                            LEFT JOIN (
                                                          SELECT *
                                                          FROM persist.visit_detail_map
                                                          WHERE source_name = 'seattle'
                                                      ) vdm
                                                      ON vdm.old_id = de.visit_occurrence_id
                               )
INSERT
INTO
    device_exposure
SELECT row_number() over (ORDER BY src_name, src_table_id) AS device_exposure_id, person_id,
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
