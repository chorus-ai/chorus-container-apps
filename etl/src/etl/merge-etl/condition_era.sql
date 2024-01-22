CREATE TABLE cond_era_target AS
SELECT
    co.person_id,
    co.condition_concept_id,
    co.condition_start_date,
    COALESCE(co.condition_end_date, dateadd (DAY, 1, condition_start_date)) AS condition_end_date
FROM
    condition_occurrence co;


CREATE TABLE cond_era_end_dates
SELECT
    person_id,
    condition_concept_id,
    dateadd (DAY, - 30, event_date) AS end_date -- unpad the end date
FROM
    (
        SELECT
            e1.person_id,
            e1.condition_concept_id,
            e1.event_date,
            COALESCE(e1.start_ordinal, MAX(e2.start_ordinal)) start_ordinal,
            e1.overall_ord
        FROM
            (
                SELECT
                    person_id,
                    condition_concept_id,
                    event_date,
                    event_type,
                    start_ordinal,
                    ROW_NUMBER() OVER    (
                        PARTITION BY
                            person_id,
                            condition_concept_id
                        ORDER BY
                            event_date,
                            event_type
                    ) AS overall_ord -- this re-numbers the inner union so all rows are numbered ordered by the event date
                FROM
                    (
                        -- select the start dates, assigning a row number to each
                        SELECT
                            person_id,
                            condition_concept_id,
                            condition_start_date AS event_date,
                            - 1                  AS event_type,
                            ROW_NUMBER() OVER    (
                                PARTITION BY
                                    person_id,
                                    condition_concept_id
                                ORDER BY
                                    condition_start_date
                            ) AS start_ordinal
                        FROM
                            cond_era_target
                        UNION ALL
                        -- pad the end dates by 30 to allow a grace period for overlapping ranges.
                        SELECT
                            person_id,
                            condition_concept_id,
                            dateadd (DAY, 30,    condition_end_date),
                            1                    AS event_type,
                            NULL
                        FROM
                            cond_era_target
                    ) rawdata
            ) e1
            INNER JOIN (
                SELECT
                    person_id,
                    condition_concept_id,
                    condition_start_date AS event_date,
                    ROW_NUMBER() OVER    (
                        PARTITION BY
                            person_id,
                            condition_concept_id
                        ORDER BY
                            condition_start_date
                    ) AS start_ordinal
                FROM
                    cond_era_target
            ) e2 ON e1.person_id = e2.person_id
            AND e1.condition_concept_id = e2.condition_concept_id
            AND e2.event_date <= e1.event_date
        GROUP BY
            e1.person_id,
            e1.condition_concept_id,
            e1.event_date,
            e1.start_ordinal,
            e1.overall_ord
    ) e
WHERE
    (2 * e.start_ordinal) - e.overall_ord = 0;


CREATE TABLE cond_era_ends AS
SELECT
    c.person_id,
    c.condition_concept_id,
    c.condition_start_date,
    MIN(e.end_date)        AS era_end_date
FROM
    cond_era_target c
    INNER JOIN cond_era_end_dates e ON c.person_id = e.person_id
    AND c.condition_concept_id = e.condition_concept_id
    AND e.end_date >= c.condition_start_date
GROUP BY
    c.person_id,
    c.condition_concept_id,
    c.condition_start_date;


INSERT INTO
    condition_era
SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            person_id
    ) AS condition_era_id,
    CAST(person_id AS integer) AS person_id,
    CAST(condition_concept_id AS integer) AS condition_concept_id,
    CAST(MIN(condition_start_date) AS DATE) AS condition_era_start_date,
    CAST(era_end_date AS DATE) AS condition_era_end_date,
    COUNT(*) AS condition_occurrence_count
FROM
    cond_era_ends
GROUP BY
    person_id,
    condition_concept_id,
    era_end_date;