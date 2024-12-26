WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'columbia'          AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM columbia.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'columbia'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'columbia'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'columbia'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'columbia'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'duke'              AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM duke.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'duke'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'duke'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'duke'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'duke'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'emory'             AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM emory.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'emory'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'emory'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'emory'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'emory'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'mgh'               AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM mgh.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'mgh'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'mgh'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'mgh'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'mgh'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'mit'               AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM mit.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'mit'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'mit'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'mit'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'mit'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'mayo'              AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM mayo.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'mayo'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'mayo'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'mayo'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'mayo'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'nationwide'        AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM nationwide.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'nationwide'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'nationwide'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'nationwide'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'nationwide'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'newmexico'         AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM newmexico.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'newmexico'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'newmexico'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'newmexico'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'newmexico'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'ucla'              AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM ucla.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'ucla'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'ucla'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'ucla'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'ucla'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'ucsf'              AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM ucsf.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'ucsf'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'ucsf'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'ucsf'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'ucsf'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'florida'           AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM florida.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'florida'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'florida'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'florida'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'florida'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'pittsburgh'        AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM pittsburgh.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'pittsburgh'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'pittsburgh'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'pittsburgh'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'pittsburgh'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'virginia'          AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM virginia.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'virginia'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'virginia'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'virginia'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'virginia'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'seattle'           AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM seattle.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'seattle'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'seattle'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'seattle'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'seattle'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;


WITH note_joined AS (
                        SELECT note_id             AS src_table_id,
                               person_id           AS src_person_id,
                               visit_occurrence_id AS src_visit_occurrence_id,
                               visit_detail_id     AS src_visit_detail_id,
                               'tufts'             AS src_name,
                               nm.new_id           AS note_id,
                               pm.new_id           AS person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               note_title,
                               note_text,
                               encoding_concept_id,
                               language_concept_id,
                               vom.new_id          AS visit_occurrence_id,
                               vdm.new_id          AS visit_detail_id,
                               note_source_value,
                               note_event_id,
                               note_event_field_concept_id
                        FROM tufts.note n
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.person_map
                                                WHERE source_name = 'tufts'
                                            ) pm
                                            ON pm.old_id = n.person_id
                                 INNER JOIN (
                                                SELECT *
                                                FROM persist.note_map
                                                WHERE source_name = 'tufts'
                                            ) nm
                                            ON nm.old_id = n.note_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_occurrence_map
                                               WHERE source_name = 'tufts'
                                           ) vom
                                           ON vom.old_id = n.visit_occurrence_id
                                 LEFT JOIN (
                                               SELECT *
                                               FROM persist.visit_detail_map
                                               WHERE source_name = 'tufts'
                                           ) vdm
                                           ON vdm.old_id = n.visit_detail_id
                    )
INSERT
INTO
    note
SELECT note_id,
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
FROM note_joined;
