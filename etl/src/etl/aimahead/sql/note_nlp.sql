WITH note_nlp_joined AS (
                            SELECT note_nlp_id,
                                   note_id,
                                   section_concept_id,
                                   '<REDACTED>' AS snippet,
                                   "offset",
                                   '<REDACTED>' AS lexical_variant,
                                   note_nlp_concept_id,
                                   note_nlp_source_concept_id,
                                   nlp_system,
                                   nlp_date,
                                   nlp_datetime,
                                   term_exists,
                                   term_temporal,
                                   term_modifiers,
                                   NULL::bigint AS src_table_id,
                                   NULL::bigint AS src_note_id,
                                   sk.s_key AS src_name
                            FROM aimahead.note_nlp n
                                     JOIN persist.source_key sk ON n.src_name = sk.s_name
                            WHERE note_id IN (
                                                 SELECT note_id
                                                 FROM aimahead_60.note
                                             )
                        )
INSERT INTO aimahead_60.note_nlp
SELECT note_nlp_id,
       note_id,
       section_concept_id,
       snippet,
       "offset",
       lexical_variant,
       note_nlp_concept_id,
       note_nlp_source_concept_id,
       nlp_system,
       nlp_date,
       nlp_datetime,
       term_exists,
       term_temporal,
       term_modifiers,
       src_table_id,
       src_note_id,
       src_name
FROM note_nlp_joined;