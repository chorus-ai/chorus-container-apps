    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'columbia' AS source_name
        FROM columbia.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'columbia')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'duke' AS source_name
        FROM duke.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'duke')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'emory' AS source_name
        FROM emory.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'emory')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'mgh' AS source_name
        FROM mgh.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'mgh')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'mit' AS source_name
        FROM mit.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'mit')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'mayo' AS source_name
        FROM mayo.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'mayo')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'nationwide' AS source_name
        FROM nationwide.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'nationwide')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'newmexico' AS source_name
        FROM newmexico.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'newmexico')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'ucla' AS source_name
        FROM ucla.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'ucla')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'ucsf' AS source_name
        FROM ucsf.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'ucsf')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'florida' AS source_name
        FROM florida.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'florida')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'pittsburgh' AS source_name
        FROM pittsburgh.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'pittsburgh')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'virginia' AS source_name
        FROM virginia.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'virginia')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'seattle' AS source_name
        FROM seattle.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'seattle')
        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;


    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'tufts' AS source_name
        FROM tufts.visit_detail
        WHERE visit_detail_id NOT IN
              (SELECT old_id FROM persist.visit_detail_map WHERE source_name = 'tufts')
                        )
    INSERT INTO persist.visit_detail_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_detail_map) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined
;