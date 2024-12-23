WITH note_joined AS (
    SELECT note_id AS old_id,
           'columbia' AS source_name
    FROM columbia.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'columbia')
    UNION
    SELECT note_id AS old_id,
           'duke' AS source_name
    FROM duke.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'duke')
    UNION
    SELECT note_id AS old_id,
           'emory' AS source_name
    FROM emory.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'emory')
    UNION
    SELECT note_id AS old_id,
           'mgh' AS source_name
    FROM mgh.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'mgh')
    UNION
    SELECT note_id AS old_id,
           'mit' AS source_name
    FROM mit.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'mit')
    UNION
    SELECT note_id AS old_id,
           'mayo' AS source_name
    FROM mayo.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'mayo')
    UNION
    SELECT note_id AS old_id,
           'nationwide'
    FROM nationwide.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'nationwide')
    UNION
    SELECT note_id AS old_id,
           'newmexico' AS source_name
    FROM newmexico.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'newmexico')
    UNION
    SELECT note_id AS old_id,
           'ucla' AS source_name
    FROM ucla.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'ucla')
    UNION
    SELECT note_id AS old_id,
           'ucsf' AS source_name
    FROM ucsf.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'ucsf')
    UNION
    SELECT note_id AS old_id,
           'florida' AS source_name
    FROM florida.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'florida')
    UNION
    SELECT note_id AS old_id,
           'pittsburgh' AS source_name
    FROM pittsburgh.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'pittsburgh')
    UNION
    SELECT note_id AS old_id,
           'virginia' AS source_name
    FROM virginia.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'virginia')
    UNION
    SELECT note_id AS old_id,
           'seattle' AS source_name
    FROM seattle.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'seattle')
    UNION
    SELECT note_id AS old_id,
           'tufts' AS source_name
    FROM tufts.note
    WHERE note_id NOT IN
          (SELECT old_id FROM persist.note_map WHERE source_name = 'tufts')
                    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined;