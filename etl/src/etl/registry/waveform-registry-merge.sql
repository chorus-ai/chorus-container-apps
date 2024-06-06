WITH wr_joined AS (
                      SELECT de.person_id           AS src_person_id,
                             'mgh'               AS src_name,
                             file_id             AS src_file_id,
                             file_datetime       AS src_file_datetime,
                             visit_occurrence_id AS src_visit_occurrence_id,
                             pm.new_id           AS person_id,
                             group_id,
                             vom.new_id          AS visit_occurrence_id,
                             file_datetime  + INTERVAL '1 day'*ds.days AS file_datetime,
                             src_file,
                             trg_file
                      FROM mgh.waveform_reg de
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.person_map
                                              WHERE source_name = 'mgh'
                                          ) pm
                                          ON pm.old_id = de.person_id
                               INNER JOIN (
                                             SELECT *
                                             FROM persist.visit_occurrence_map
                                             WHERE source_name = 'mgh'
                                         ) vom
                                         ON vom.old_id = de.visit_occurrence_id
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.date_shift
                                              WHERE src_name = 'mgh'
                                          ) ds
                                         ON de.person_id = ds.src_person_id
                      UNION
                      SELECT de.person_id           AS src_person_id,
                             'nationwide'        AS src_name,
                             file_id             AS src_file_id,
                             file_datetime       AS src_file_datetime,
                             visit_occurrence_id AS src_visit_occurrence_id,
                             pm.new_id           AS person_id,
                             group_id,
                             vom.new_id          AS visit_occurrence_id,
                             file_datetime  + INTERVAL '1 day'*ds.days AS file_datetime,
                             src_file,
                             trg_file
                      FROM nationwide.waveform_reg de
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.person_map
                                              WHERE source_name = 'nationwide'
                                          ) pm
                                          ON pm.old_id = de.person_id
                               INNER JOIN (
                                             SELECT *
                                             FROM persist.visit_occurrence_map
                                             WHERE source_name = 'nationwide'
                                         ) vom
                                         ON vom.old_id = de.visit_occurrence_id
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.date_shift
                                              WHERE src_name = 'nationwide'
                                          ) ds
                                         ON de.person_id = ds.src_person_id
                      UNION
                      SELECT de.person_id           AS src_person_id,
                             'seattle'           AS src_name,
                             file_id             AS src_file_id,
                             file_datetime       AS src_file_datetime,
                             visit_occurrence_id AS src_visit_occurrence_id,
                             pm.new_id           AS person_id,
                             group_id,
                             vom.new_id          AS visit_occurrence_id,
                             file_datetime  + INTERVAL '1 day'*ds.days AS file_datetime,
                             src_file,
                             trg_file
                      FROM seattle.waveform_reg de
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.person_map
                                              WHERE source_name = 'seattle'
                                          ) pm
                                          ON pm.old_id = de.person_id
                               INNER JOIN (
                                             SELECT *
                                             FROM persist.visit_occurrence_map
                                             WHERE source_name = 'seattle'
                                         ) vom
                                         ON vom.old_id = de.visit_occurrence_id
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.date_shift
                                              WHERE src_name = 'seattle'
                                          ) ds
                                         ON de.person_id = ds.src_person_id
                  )
INSERT
INTO
    PUBLIC.waveform_reg
SELECT row_number() OVER (ORDER BY src_name, src_file_id) + 2001000000 AS file_id,
       person_id,
       group_id,
       visit_occurrence_id,
       file_datetime,
       src_file,
       trg_file,
       src_person_id,
       src_name,
       src_file_id,
       src_file_datetime,
       src_visit_occurrence_id
FROM wr_joined;

