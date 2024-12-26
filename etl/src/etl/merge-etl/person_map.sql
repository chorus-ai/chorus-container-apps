    WITH person_joined AS (
        SELECT person_id AS old_id,
               'columbia' AS source_name
        FROM columbia.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'columbia')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'duke' AS source_name
        FROM duke.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'duke')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'emory' AS source_name
        FROM emory.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'emory')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'mgh' AS source_name
        FROM mgh.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'mgh')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'mit' AS source_name
        FROM mit.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'mit')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'mayo' AS source_name
        FROM mayo.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'mayo')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'nationwide'
        FROM nationwide.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'nationwide')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'newmexico' AS source_name
        FROM newmexico.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'newmexico')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'ucla' AS source_name
        FROM ucla.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'ucla')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'ucsf' AS source_name
        FROM ucsf.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'ucsf')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'florida' AS source_name
        FROM florida.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'florida')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'pittsburgh' AS source_name
        FROM pittsburgh.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'pittsburgh')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'virginia' AS source_name
        FROM virginia.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'virginia')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'seattle' AS source_name
        FROM seattle.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'seattle')
         )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;


    WITH person_joined AS (
        SELECT person_id AS old_id,
               'tufts' AS source_name
        FROM tufts.person
        WHERE person_id NOT IN
              (SELECT old_id FROM persist.person_map WHERE source_name = 'tufts')
                        )
    INSERT INTO persist.person_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.person_map) AS new_id,
           old_id,
           source_name
    FROM person_joined;