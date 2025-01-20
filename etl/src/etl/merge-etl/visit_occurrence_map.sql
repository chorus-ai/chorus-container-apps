WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'columbia' AS source_name
        FROM columbia.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'columbia') vm
		ON visit_occurrence_id = old_id

         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


   WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'duke' AS source_name
        FROM duke.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'duke') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'emory' AS source_name
        FROM emory.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'emory') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'mgh' AS source_name
        FROM mgh.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mgh') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'mit' AS source_name
        FROM mit.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mit') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'mayo' AS source_name
        FROM mayo.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'mayo') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'nationwide' AS source_name
        FROM nationwide.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'nationwide') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


   WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'newmexico' AS source_name
        FROM newmexico.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'newmexico') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'ucla' AS source_name
        FROM ucla.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucla') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;

    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'ucsf' AS source_name
        FROM ucsf.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'ucsf') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'florida' AS source_name
        FROM florida.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'florida') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


   WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'pittsburgh' AS source_name
        FROM pittsburgh.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'pittsburgh') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'virginia' AS source_name
        FROM virginia.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'virginia') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'seattle' AS source_name
        FROM seattle.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'seattle') vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;


    WITH visit_occurrence_joined AS (
        SELECT visit_occurrence_id AS old_id,
		       vm.old_id AS idexists,
               'tufts' AS source_name
        FROM tufts.visit_occurrence v
        LEFT JOIN (SELECT * FROM persist.visit_occurrence_map WHERE source_name = 'tufts')  vm
		ON visit_occurrence_id = old_id
         )
    INSERT INTO persist.visit_occurrence_map
    SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.visit_occurrence_map) AS new_id,
           old_id,
           source_name
    FROM visit_occurrence_joined
	WHERE idexists IS NULL;
