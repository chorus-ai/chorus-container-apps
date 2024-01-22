CREATE TABLE note_map AS (
    WITH note_joined AS (
        SELECT note_id AS old_id,
               'columbia' AS source_name
        FROM columbia.note
        UNION
        SELECT note_id AS old_id,
               'duke' AS source_name
        FROM duke.note
        UNION
        SELECT note_id AS old_id,
               'emory' AS source_name
        FROM emory.note
        UNION
        SELECT note_id AS old_id,
               'mgh' AS source_name
        FROM mgh.note
        UNION
        SELECT note_id AS old_id,
               'mit' AS source_name
        FROM mit.note
        UNION
        SELECT note_id AS old_id,
               'mayo' AS source_name
        FROM mayo.note
        UNION
        SELECT note_id AS old_id,
               'nationwide'
        FROM nationwide.note
        UNION
        SELECT note_id AS old_id,
               'newmexico' AS source_name
        FROM newmexico.note
        UNION
        SELECT note_id AS old_id,
               'ucla' AS source_name
        FROM ucla.note
        UNION
        SELECT note_id AS old_id,
               'ucsf' AS source_name
        FROM ucsf.note
        UNION
        SELECT note_id AS old_id,
               'florida' AS source_name
        FROM florida.note
        UNION
        SELECT note_id AS old_id,
               'pittsburgh' AS source_name
        FROM pittsburgh.note
        UNION
        SELECT note_id AS old_id,
               'virginia' AS source_name
        FROM virginia.note
        UNION
        SELECT note_id AS old_id,
               'seattle' AS source_name
        FROM seattle.note
                        )
    SELECT row_number() OVER (ORDER BY source_name, old_id) AS new_id,
           old_id,
           source_name
    FROM note_joined;