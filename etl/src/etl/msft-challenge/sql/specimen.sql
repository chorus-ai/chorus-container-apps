WITH specimen_joined AS (
                            SELECT NULL AS src_table_id,
                                   NULL   AS src_person_id,
                                   CASE WHEN src_name = 'mgh' THEN '1'
                                           WHEN src_name = 'mit' THEN '2'
                                           WHEN src_name = 'nationwide' THEN '3'
                                           WHEN src_name = 'pittsburgh' THEN '4'
                                           WHEN src_name = 'seattle' THEN '5'
                                      END AS src_name,
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
                            FROM msft_challenge.specimen s
                                       WHERE person_id IN (SELECT person_id FROM msft_challenge_80.person)
                        )
INSERT
INTO
    msft_challenge_80.specimen
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
