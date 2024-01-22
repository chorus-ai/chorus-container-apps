CREATE TABLE person_map AS (
    WITH person_joined AS (
        SELECT person_id AS old_id,
               'columbia' AS source_name
        FROM columbia.person
        UNION
        SELECT person_id AS old_id,
               'duke' AS source_name
        FROM duke.person
        UNION
        SELECT person_id AS old_id,
               'emory' AS source_name
        FROM emory.person
        UNION
        SELECT person_id AS old_id,
               'mgh' AS source_name
        FROM mgh.person
        UNION
        SELECT person_id AS old_id,
               'mit' AS source_name
        FROM mit.person
        UNION
        SELECT person_id AS old_id,
               'mayo' AS source_name
        FROM mayo.person
        UNION
        SELECT person_id AS old_id,
               'nationwide'
        FROM nationwide.person
        UNION
        SELECT person_id AS old_id,
               'newmexico' AS source_name
        FROM newmexico.person
        UNION
        SELECT person_id AS old_id,
               'ucla' AS source_name
        FROM ucla.person
        UNION
        SELECT person_id AS old_id,
               'ucsf' AS source_name
        FROM ucsf.person
        UNION
        SELECT person_id AS old_id,
               'florida' AS source_name
        FROM florida.person
        UNION
        SELECT person_id AS old_id,
               'pittsburgh' AS source_name
        FROM pittsburgh.person
        UNION
        SELECT person_id AS old_id,
               'virginia' AS source_name
        FROM virginia.person
        UNION
        SELECT person_id AS old_id,
               'seattle' AS source_name
        FROM seattle.person
                        )
    SELECT row_number() OVER (ORDER BY source_name, old_id) AS new_id,
           old_id,
           source_name
    FROM person_joined;