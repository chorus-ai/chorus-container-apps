WITH specimen_joined AS (
                            SELECT NULL::bigint AS src_table_id,
                                   NULL::bigint   AS src_person_id,
                                   sk.s_key AS src_name,
                                   specimen_id,
                                   person_id,
                                   specimen_concept_id,
                                   specimen_type_concept_id,
                                   specimen_date,
                                   specimen_datetime,
                                   quantity,
                                   unit_concept_id,
                                   anatomic_site_concept_id,
                                   disease_status_concept_id,
                                   specimen_source_id,
                                   NULL AS specimen_source_value,
                                   unit_source_value,
                                   NULL AS anatomic_site_source_value,
                                   NULL AS disease_status_source_value
                            FROM aimahead.specimen s
                                JOIN persist.source_key sk ON src_name = sk.s_name
                                WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
                                AND specimen_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
                        )
INSERT
INTO
    aimahead_60.specimen
SELECT specimen_id,
       person_id,
       specimen_concept_id,
       specimen_type_concept_id,
       specimen_date,
       specimen_datetime,
       quantity,
       unit_concept_id,
       anatomic_site_concept_id,
       disease_status_concept_id,
       specimen_source_id,
       specimen_source_value,
       unit_source_value,
       anatomic_site_source_value,
       disease_status_source_value,
       src_table_id,
       src_person_id,
       src_name
FROM specimen_joined;
