CREATE
TEMP TABLE tmp_de
AS
WITH ctePreDrugTarget(drug_exposure_id, person_id, ingredient_concept_id, drug_exposure_start_date, days_supply, drug_exposure_end_date)   AS (SELECT d.drug_exposure_id
        , d.person_id
        , C.concept_id AS ingredient_concept_id
        , d.drug_exposure_start_date AS drug_exposure_start_date
        , d.days_supply AS days_supply
        , COALESCE(
            ---NULLIF returns NULL if both values are the same, otherwise it returns the first parameter
            NULLIF(drug_exposure_end_date, NULL),
            ---If drug_exposure_end_date != NULL, return drug_exposure_end_date, otherwise go to next case
            NULLIF((drug_exposure_start_date + days_supply*INTERVAL'1 day'), drug_exposure_start_date),
            ---If days_supply != NULL or 0, return drug_exposure_start_date + days_supply, otherwise go to next case
            (drug_exposure_start_date + 1*INTERVAL'1 day')
            ---Add 1 day to the drug_exposure_start_date since there is no end_date or INTERVAL for the days_supply
        ) AS drug_exposure_end_date
    FROM omopcdm.drug_exposure d
        JOIN omopcdm.concept_ancestor ca ON ca.descendant_concept_id = d.drug_concept_id
        JOIN omopcdm.concept C ON ca.ancestor_concept_id = C.concept_id
        WHERE C.vocabulary_id =  CAST('RxNorm' AS TEXT) AND C.concept_class_id = 'Ingredient'
        AND d.drug_concept_id != 0 ---Our unmapped drug_concept_id's are set to 0, so we don't want different drugs wrapped up in the same era
        AND COALESCE(d.days_supply,0) >= 0 ---We have cases where days_supply is negative, and this can set the end_date before the start_date, which we don't want. So we're just looking over those rows. This is a data-quality issue.
)
, cteSubExposureEndDates (person_id, ingredient_concept_id, end_date) AS --- A preliminary sorting that groups all of the overlapping exposures into one exposure so that we don't double-count non-gap-days
(
    SELECT person_id, ingredient_concept_id, event_date AS end_date
    FROM
    (
        SELECT person_id, ingredient_concept_id, event_date, event_type,
        MAX(start_ordinal) OVER (PARTITION BY person_id, ingredient_concept_id
            ORDER BY event_date, event_type ROWS UNBOUNDED PRECEDING) AS start_ordinal,
        -- this pulls the current START down from the prior rows so that the NULLs
        -- from the END DATES will contain a value we can compare with
            ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id
                ORDER BY event_date, event_type) AS overall_ord
            -- this re-numbers the inner UNION so all rows are numbered ordered by the event date
        FROM (
            -- select the start dates, assigning a row number to each
            SELECT person_id, ingredient_concept_id, drug_exposure_start_date AS event_date,
            -1 AS event_type,
            ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id
                ORDER BY drug_exposure_start_date) AS start_ordinal
            FROM ctePreDrugTarget
            UNION ALL
            SELECT person_id, ingredient_concept_id, drug_exposure_end_date, 1 AS event_type, NULL
            FROM ctePreDrugTarget
        ) RAWDATA
    ) e
    WHERE (2 * e.start_ordinal) - e.overall_ord = 0
)
, cteDrugExposureEnds (person_id, drug_concept_id, drug_exposure_start_date, drug_sub_exposure_end_date) AS
(
SELECT
    dt.person_id
    , dt.ingredient_concept_id
    , dt.drug_exposure_start_date
    , MIN(e.end_date) AS drug_sub_exposure_end_date
FROM ctePreDrugTarget dt
JOIN cteSubExposureEndDates e ON dt.person_id = e.person_id AND dt.ingredient_concept_id = e.ingredient_concept_id AND e.end_date >= dt.drug_exposure_start_date
GROUP BY
        dt.drug_exposure_id
        , dt.person_id
    , dt.ingredient_concept_id
    , dt.drug_exposure_start_date
)
--------------------------------------------------------------------------------------------------------------
, cteSubExposures(row_number, person_id, drug_concept_id, drug_sub_exposure_start_date, drug_sub_exposure_end_date, drug_exposure_count) AS
(
    SELECT ROW_NUMBER() OVER (PARTITION BY person_id, drug_concept_id, drug_sub_exposure_end_date ORDER BY person_id)
        , person_id, drug_concept_id, MIN(drug_exposure_start_date) AS drug_sub_exposure_start_date, drug_sub_exposure_end_date, COUNT(*) AS drug_exposure_count
    FROM cteDrugExposureEnds
    GROUP BY person_id, drug_concept_id, drug_sub_exposure_end_date
    --ORDER BY person_id, drug_concept_id
)
--------------------------------------------------------------------------------------------------------------
/*Everything above grouped exposures into sub_exposures if there was overlap between exposures.
 *So there was no persistence window. Now we can add the persistence window to calculate eras.
 */
--------------------------------------------------------------------------------------------------------------
, cteFinalTarget(row_number, person_id, ingredient_concept_id, drug_sub_exposure_start_date, drug_sub_exposure_end_date, drug_exposure_count, days_exposed) AS
(
    SELECT row_number, person_id, drug_concept_id, drug_sub_exposure_start_date, drug_sub_exposure_end_date, drug_exposure_count
        , (CAST(drug_sub_exposure_end_date AS DATE) - CAST(drug_sub_exposure_start_date AS DATE)) AS days_exposed
    FROM cteSubExposures
)
--------------------------------------------------------------------------------------------------------------
, cteEndDates (person_id, ingredient_concept_id, end_date) AS -- the magic
(
    SELECT person_id, ingredient_concept_id, (event_date + -30*INTERVAL'1 day') AS end_date -- unpad the end date
    FROM
    (
        SELECT person_id, ingredient_concept_id, event_date, event_type,
        MAX(start_ordinal) OVER (PARTITION BY person_id, ingredient_concept_id
            ORDER BY event_date, event_type ROWS UNBOUNDED PRECEDING) AS start_ordinal,
        -- this pulls the current START down from the prior rows so that the NULLs
        -- from the END DATES will contain a value we can compare with
            ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id
                ORDER BY event_date, event_type) AS overall_ord
            -- this re-numbers the inner UNION so all rows are numbered ordered by the event date
        FROM (
            -- select the start dates, assigning a row number to each
            SELECT person_id, ingredient_concept_id, drug_sub_exposure_start_date AS event_date,
            -1 AS event_type,
            ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id
                ORDER BY drug_sub_exposure_start_date) AS start_ordinal
            FROM cteFinalTarget
            UNION ALL
            -- pad the end dates by 30 to allow a grace period for overlapping ranges.
            SELECT person_id, ingredient_concept_id, (drug_sub_exposure_end_date + 30*INTERVAL'1 day'), 1 AS event_type, NULL
            FROM cteFinalTarget
        ) RAWDATA
    ) e
    WHERE (2 * e.start_ordinal) - e.overall_ord = 0
)
, cteDrugEraEnds (person_id, drug_concept_id, drug_sub_exposure_start_date, drug_era_end_date, drug_exposure_count, days_exposed) AS
(
SELECT
    ft.person_id
    , ft.ingredient_concept_id
    , ft.drug_sub_exposure_start_date
    , MIN(e.end_date) AS era_end_date
    , drug_exposure_count
    , days_exposed
FROM cteFinalTarget ft
JOIN cteEndDates e ON ft.person_id = e.person_id AND ft.ingredient_concept_id = e.ingredient_concept_id AND e.end_date >= ft.drug_sub_exposure_start_date
GROUP BY
        ft.person_id
    , ft.ingredient_concept_id
    , ft.drug_sub_exposure_start_date
    , drug_exposure_count
    , days_exposed
)
SELECT row_number()                                                                                               over(ORDER BY person_id) drug_era_id
    , person_id
        ,
       drug_concept_id
        ,
       MIN(drug_sub_exposure_start_date)                                                                       AS drug_era_start_date
        ,
       drug_era_end_date
        ,
       SUM(drug_exposure_count)                                                                                AS drug_exposure_count
        ,
       (CAST(drug_era_end_date AS DATE) - CAST(MIN(drug_sub_exposure_start_date) AS DATE)) -
       SUM(days_exposed)                                                                                       AS gap_days
FROM ctedrugeraends dee
GROUP BY person_id,
         drug_concept_id,
         drug_era_end_date;
ANALYZE
tmp_de
;
INSERT INTO
    omopcdm.drug_era(
                        drug_era_id,
                        person_id,
                        drug_concept_id,
                        drug_era_start_date,
                        drug_era_end_date,
                        drug_exposure_count,
                        gap_days
                    )
SELECT *
FROM tmp_de;
/****
CONDITION ERA
Note: Eras derived from CONDITION_OCCURRENCE table, using 30d gap
 ****/
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

FROM omopcdm.condition_occurrence co
WHERE co.condition_concept_id != 0;
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
                               )                       AS start_ordinal
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
                 )                       AS start_ordinal
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
    )                            AS condition_era_id
     , person_id
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

CREATE INDEX idx_drug_era_person_id_1 ON omopcdm.drug_era (person_id ASC);
CLUSTER
omopcdm.drug_era USING idx_drug_era_person_id_1;
CREATE INDEX idx_drug_era_concept_id_1 ON omopcdm.drug_era (drug_concept_id ASC);

CREATE INDEX idx_dose_era_person_id_1 ON omopcdm.dose_era (person_id ASC);
CLUSTER
omopcdm.dose_era USING idx_dose_era_person_id_1;
CREATE INDEX idx_dose_era_concept_id_1 ON omopcdm.dose_era (drug_concept_id ASC);

CREATE INDEX idx_condition_era_person_id_1 ON omopcdm.condition_era (person_id ASC);
CLUSTER
omopcdm.condition_era USING idx_condition_era_person_id_1;
CREATE INDEX idx_condition_era_concept_id_1 ON omopcdm.condition_era (condition_concept_id ASC);

ALTER TABLE omopcdm.drug_era
    ADD CONSTRAINT xpk_drug_era PRIMARY KEY (drug_era_id);

ALTER TABLE omopcdm.dose_era
    ADD CONSTRAINT xpk_dose_era PRIMARY KEY (dose_era_id);

ALTER TABLE omopcdm.condition_era
    ADD CONSTRAINT xpk_condition_era PRIMARY KEY (condition_era_id);