CREATE TABLE visit_detail_map AS (
    WITH visit_detail_joined AS (
        SELECT visit_detail_id AS old_id,
               'columbia' AS source_name
        FROM columbia.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'duke' AS source_name
        FROM duke.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'emory' AS source_name
        FROM emory.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'mgh' AS source_name
        FROM mgh.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'mit' AS source_name
        FROM mit.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'mayo' AS source_name
        FROM mayo.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'nationwide'
        FROM nationwide.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'newmexico' AS source_name
        FROM newmexico.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'ucla' AS source_name
        FROM ucla.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'ucsf' AS source_name
        FROM ucsf.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'florida' AS source_name
        FROM florida.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'pittsburgh' AS source_name
        FROM pittsburgh.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'virginia' AS source_name
        FROM virginia.visit_detail
        UNION
        SELECT visit_detail_id AS old_id,
               'seattle' AS source_name
        FROM seattle.visit_detail
                        )
    SELECT row_number() OVER (ORDER BY source_name, old_id) AS new_id,
           old_id,
           source_name
    FROM visit_detail_joined;