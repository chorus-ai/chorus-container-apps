DROP TABLE if exists persist.date_shift;
CREATE TABLE persist.date_shift (
    person_id bigint,
    days integer,
    src_name text,
    src_person_id bigint
);

WITH ds_joined AS (
                      SELECT person_id           AS src_person_id,
                             'mgh'               AS src_name,
                             pm.new_id           AS person_id,
                             days
                      FROM mgh.date_shift de
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.person_map
                                              WHERE source_name = 'mgh'
                                          ) pm
                                          ON pm.old_id = de.person_id
                      UNION
                      SELECT person_id           AS src_person_id,
                             'nationwide'        AS src_name,
                             pm.new_id           AS person_id,
                             days
                      FROM nationwide.date_shift de
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.person_map
                                              WHERE source_name = 'nationwide'
                                          ) pm
                                          ON pm.old_id = de.person_id
                      UNION
                      SELECT person_id           AS src_person_id,
                             'seattle'           AS src_name,
                             pm.new_id           AS person_id,
                             days
                      FROM seattle.date_shift de
                               INNER JOIN (
                                              SELECT *
                                              FROM persist.person_map
                                              WHERE source_name = 'seattle'
                                          ) pm
                                          ON pm.old_id = de.person_id
                  )
INSERT
INTO
    persist.date_shift
SELECT person_id bigint,
    days integer,
    src_name text,
    src_person_id bigint
FROM ds_joined;

