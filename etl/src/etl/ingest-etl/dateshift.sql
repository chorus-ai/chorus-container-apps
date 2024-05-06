INSERT INTO
    persist.date_shift (person_id, days)
SELECT
    person_id::bigint,
    (random() * 61)::int - 30 AS days
FROM omopcdm.src_person
WHERE person_id::bigint NOT IN (SELECT person_id FROM persist.date_shift);

UPDATE persist.date_shift
SET days = (random() * 61)::int - 30
WHERE days = 0;


