WITH note_joined AS (
                        SELECT note_id,
                               person_id,
                               note_date,
                               note_datetime,
                               note_type_concept_id,
                               note_class_concept_id,
                               '<REDACTED>'  AS note_title,
                               '<REDACTED>'  AS note_text,
                               encoding_concept_id,
                               language_concept_id,
                               NULL::bigint     AS provider_id,
                               visit_occurrence_id,
                               visit_detail_id,
                               NULL     AS note_source_value,
                               note_event_id,
                               note_event_field_concept_id,
                               NULL::bigint      AS src_table_id,
                               NULL::bigint      AS src_person_id,
                               NULL::bigint      AS src_visit_occurrence_id,
                               NULL::bigint     AS src_visit_detail_id,
                               sk.s_key AS src_name
                        FROM aimahead.note n
                                 JOIN persist.source_key sk ON n.src_name = sk.s_name
                        WHERE person_id IN (
                                               SELECT person_id
                                               FROM aimahead_60.person
                                           )
                    )
INSERT
INTO aimahead_60.note
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
       provider_id,
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