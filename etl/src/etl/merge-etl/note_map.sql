WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'columbia' AS source_name
    FROM columbia.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'columbia'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'duke' AS source_name
    FROM duke.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'duke'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'emory' AS source_name
    FROM emory.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'emory'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'mgh' AS source_name
    FROM mgh.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'mgh'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'mit' AS source_name
    FROM mit.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'mit'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'mayo' AS source_name
    FROM mayo.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'mayo'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'nationwide' AS source_name
    FROM nationwide.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'nationwide'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'newmexico' AS source_name
    FROM newmexico.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'newmexico'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'florida' AS source_name
    FROM florida.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'florida'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'ucla' AS source_name
    FROM ucla.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'ucla'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'ucsf' AS source_name
    FROM ucsf.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'ucsf'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;


WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'pittsburgh' AS source_name
    FROM pittsburgh.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'pittsburgh'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'virginia' AS source_name
    FROM virginia.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'virginia'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'seattle' AS source_name
    FROM seattle.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'seattle'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;

WITH note_joined AS (
    SELECT note_id AS old_id,
		    nm.old_id AS idexists,
           'tufts' AS source_name
    FROM tufts.note
    LEFT JOIN persist.note_map nm
		ON note_id = old_id
		WHERE source_name = 'tufts'
    )
INSERT INTO persist.note_map
SELECT row_number() OVER (ORDER BY source_name, old_id) + (SELECT count(*) FROM persist.note_map) AS new_id,
       old_id,
       source_name
FROM note_joined
WHERE idexists IS NULL;