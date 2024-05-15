DROP TABLE if EXISTS condition_era_phase_1;
/* / */
DROP TABLE if EXISTS cteConditionTarget;
/* / */
-- create base eras from the concepts found in condition_occurrence
CREATE
TEMP TABLE cteConditionTarget
AS
SELECT co.person_id
        ,
       co.condition_concept_id
        ,
       co.condition_start_date
        ,
       COALESCE(co.condition_end_date, (condition_start_date + 1 * INTERVAL '1 day')) AS condition_end_date
FROM omopcdm.condition_occurrence co;
ANALYZE
cteConditionTarget
;
/* / */
DROP TABLE if EXISTS cteCondEndDates;
/* / */
CREATE
TEMP TABLE cteCondEndDates
AS
SELECT person_id
        ,
       condition_concept_id
        ,
       (event_date + - 30 * INTERVAL '1 day') AS end_date -- unpad the end date
FROM (
         SELECT e1.person_id
                 ,
                e1.condition_concept_id
                 ,
                e1.event_date
                 ,
                COALESCE(e1.start_ordinal, MAX(e2.start_ordinal)) start_ordinal
                 ,
                e1.overall_ord
         FROM (
                  SELECT person_id
                          ,
                         condition_concept_id
                          ,
                         event_date
                          ,
                         event_type
                          ,
                         start_ordinal
                          ,
                         row_number() over (
                partition BY PERSON_ID
                ,condition_concept_id ORDER BY EVENT_DATE
                    ,event_type
                ) AS overall_ord -- this re-numbers the inner UNION so all rows are numbered ordered by the event date
                  FROM (
                           -- select the start dates, assigning a row number to each
                           SELECT person_id
                                   ,
                                  condition_concept_id
                                   ,
                                  condition_start_date AS event_date
                                   ,
                                  - 1                  AS event_type
                                   ,
                                  row_number()            over (
                    partition BY PERSON_ID
                    ,condition_concept_id ORDER BY CONDITION_START_DATE
                    ) AS start_ordinal
                           FROM cteconditiontarget
                           UNION ALL
                           -- pad the end dates by 30 to allow a grace period for overlapping ranges.
                           SELECT person_id
                                   ,
                                  condition_concept_id
                                   ,
                                  (condition_end_date + 30 * INTERVAL '1 day')
                                   ,
                                  1 AS event_type
                                   ,
                                  NULL
                           FROM cteconditiontarget
                       ) rawdata
              ) e1
                  INNER JOIN (
                                 SELECT person_id
                                         ,
                                        condition_concept_id
                                         ,
                                        condition_start_date AS event_date
                                         ,
                                        row_number()            over (
                partition BY PERSON_ID
                ,condition_concept_id ORDER BY CONDITION_START_DATE
                ) AS start_ordinal
                                 FROM cteconditiontarget
                             ) e2 ON e1.person_id = e2.person_id
             AND e1.condition_concept_id = e2.condition_concept_id
             AND e2.event_date <= e1.event_date
         GROUP BY e1.person_id
                 ,
                  e1.condition_concept_id
                 ,
                  e1.event_date
                 ,
                  e1.start_ordinal
                 ,
                  e1.overall_ord
     ) e
WHERE (2 * e.start_ordinal) - e.overall_ord = 0;
ANALYZE
cteCondEndDates
;
/* / */
DROP TABLE if EXISTS cteConditionEnds;
/* / */
CREATE
TEMP TABLE cteConditionEnds
AS
SELECT c.person_id
        ,
       c.condition_concept_id
        ,
       c.condition_start_date
        ,
       MIN(e.end_date) AS era_end_date
FROM cteconditiontarget c
         INNER JOIN ctecondenddates e ON c.person_id = e.person_id
    AND c.condition_concept_id = e.condition_concept_id
    AND e.end_date >= c.condition_start_date
GROUP BY c.person_id
        ,
         c.condition_concept_id
        ,
         c.condition_start_date;
ANALYZE
cteConditionEnds
;
/* / */
INSERT INTO
    omopcdm.condition_era (
                              condition_era_id,
                              person_id,
                              condition_concept_id,
                              condition_era_start_date,
                              condition_era_end_date,
                              condition_occurrence_count
                          )
SELECT row_number()                 over (
        ORDER BY person_id
        ) AS condition_era_id
    ,person_id
        ,
       condition_concept_id
        ,
       MIN(condition_start_date) AS condition_era_start_date
        ,
       era_end_date              AS condition_era_end_date
        ,
       COUNT(*)                  AS condition_occurrence_count
FROM cteconditionends
GROUP BY person_id
        ,
         condition_concept_id
        ,
         era_end_date;


CREATE INDEX idx_condition_era_person_id_1 ON omopcdm.condition_era (person_id ASC);
CLUSTER omopcdm.condition_era USING idx_condition_era_person_id_1;
CREATE INDEX idx_condition_era_concept_id_1 ON omopcdm.condition_era (condition_concept_id ASC);

ALTER TABLE omopcdm.CONDITION_ERA
    ADD CONSTRAINT xpk_CONDITION_ERA PRIMARY KEY (condition_era_id);