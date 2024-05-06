DROP TABLE IF EXISTS cteDrugTarget;

CREATE TEMP TABLE cteDrugTarget
AS
SELECT d.DRUG_EXPOSURE_ID
     , d.PERSON_ID
     , c.CONCEPT_ID
     , d.DRUG_TYPE_CONCEPT_ID
     , DRUG_EXPOSURE_START_DATE
     , COALESCE(DRUG_EXPOSURE_END_DATE, (DRUG_EXPOSURE_START_DATE + DAYS_SUPPLY * INTERVAL '1 day'),
                (DRUG_EXPOSURE_START_DATE + 1 * INTERVAL '1 day')) AS DRUG_EXPOSURE_END_DATE
     , c.CONCEPT_ID                                                AS INGREDIENT_CONCEPT_ID

FROM omopcdm.DRUG_EXPOSURE d
         INNER JOIN omopcdm.CONCEPT_ANCESTOR ca ON ca.DESCENDANT_CONCEPT_ID = d.DRUG_CONCEPT_ID
         INNER JOIN omopcdm.CONCEPT c ON ca.ANCESTOR_CONCEPT_ID = c.CONCEPT_ID
WHERE c.VOCABULARY_ID = 'RxNorm'
  AND c.CONCEPT_CLASS_ID = 'Ingredient';

/* / */
DROP TABLE IF EXISTS cteEndDates;
/* / */
CREATE TEMP TABLE cteEndDates
AS
SELECT PERSON_ID
     , INGREDIENT_CONCEPT_ID
     , (EVENT_DATE + - 30 * INTERVAL '1 day') AS END_DATE -- unpad the end date

FROM (
         SELECT E1.PERSON_ID
              , E1.INGREDIENT_CONCEPT_ID
              , E1.EVENT_DATE
              , COALESCE(E1.START_ORDINAL, MAX(E2.START_ORDINAL)) START_ORDINAL
              , E1.OVERALL_ORD
         FROM (
                  SELECT PERSON_ID
                       , INGREDIENT_CONCEPT_ID
                       , EVENT_DATE
                       , EVENT_TYPE
                       , START_ORDINAL
                       , ROW_NUMBER() OVER (
                      PARTITION BY PERSON_ID
                          ,INGREDIENT_CONCEPT_ID ORDER BY EVENT_DATE
                          ,EVENT_TYPE
                      ) AS OVERALL_ORD -- this re-numbers the inner UNION so all rows are numbered ordered by the event date
                  FROM (
                           -- select the start dates, assigning a row number to each
                           SELECT PERSON_ID
                                , INGREDIENT_CONCEPT_ID
                                , DRUG_EXPOSURE_START_DATE AS EVENT_DATE
                                , 0                        AS EVENT_TYPE
                                , ROW_NUMBER() OVER (
                               PARTITION BY PERSON_ID
                                   ,INGREDIENT_CONCEPT_ID ORDER BY DRUG_EXPOSURE_START_DATE
                               )                           AS START_ORDINAL
                           FROM cteDrugTarget
                           UNION ALL
                           -- add the end dates with NULL as the row number, padding the end dates by 30 to allow a grace period for overlapping ranges.
                           SELECT PERSON_ID
                                , INGREDIENT_CONCEPT_ID
                                , (DRUG_EXPOSURE_END_DATE + 30 * INTERVAL '1 day')
                                , 1 AS EVENT_TYPE
                                , NULL
                           FROM cteDrugTarget
                       ) RAWDATA
              ) E1
                  INNER JOIN (
             SELECT PERSON_ID
                  , INGREDIENT_CONCEPT_ID
                  , DRUG_EXPOSURE_START_DATE AS EVENT_DATE
                  , ROW_NUMBER() OVER (
                 PARTITION BY PERSON_ID
                     ,INGREDIENT_CONCEPT_ID ORDER BY DRUG_EXPOSURE_START_DATE
                 )                           AS START_ORDINAL
             FROM cteDrugTarget
         ) E2 ON E1.PERSON_ID = E2.PERSON_ID
             AND E1.INGREDIENT_CONCEPT_ID = E2.INGREDIENT_CONCEPT_ID
             AND E2.EVENT_DATE <= E1.EVENT_DATE
         GROUP BY E1.PERSON_ID
                , E1.INGREDIENT_CONCEPT_ID
                , E1.EVENT_DATE
                , E1.START_ORDINAL
                , E1.OVERALL_ORD
     ) E
WHERE 2 * E.START_ORDINAL - E.OVERALL_ORD = 0;

/* / */
DROP TABLE IF EXISTS cteDrugExpEnds;
/* / */
CREATE TEMP TABLE cteDrugExpEnds
AS
SELECT d.PERSON_ID
     , d.INGREDIENT_CONCEPT_ID
     , d.DRUG_TYPE_CONCEPT_ID
     , d.DRUG_EXPOSURE_START_DATE
     , MIN(e.END_DATE) AS ERA_END_DATE

FROM cteDrugTarget d
         INNER JOIN cteEndDates e ON d.PERSON_ID = e.PERSON_ID
    AND d.INGREDIENT_CONCEPT_ID = e.INGREDIENT_CONCEPT_ID
    AND e.END_DATE >= d.DRUG_EXPOSURE_START_DATE
GROUP BY d.PERSON_ID
       , d.INGREDIENT_CONCEPT_ID
       , d.DRUG_TYPE_CONCEPT_ID
       , d.DRUG_EXPOSURE_START_DATE;
/* / */
INSERT INTO omopcdm.drug_era
SELECT row_number() OVER (
    ORDER BY person_id
    )                                AS drug_era_id
     , person_id
     , INGREDIENT_CONCEPT_ID
     , min(DRUG_EXPOSURE_START_DATE) AS drug_era_start_date
     , ERA_END_DATE
     , COUNT(*)                      AS DRUG_EXPOSURE_COUNT
     , 30                            AS gap_days
FROM cteDrugExpEnds
GROUP BY person_id
       , INGREDIENT_CONCEPT_ID
       , drug_type_concept_id
       , ERA_END_DATE;
/****
CONDITION ERA
Note: Eras derived from CONDITION_OCCURRENCE table, using 30d gap
 ****/
DROP TABLE IF EXISTS condition_era_phase_1;
/* / */
DROP TABLE IF EXISTS cteConditionTarget;
/* / */
-- create base eras from the concepts found in condition_occurrence
CREATE TEMP TABLE cteConditionTarget
AS
SELECT co.PERSON_ID
     , co.condition_concept_id
     , co.CONDITION_START_DATE
     , COALESCE(co.CONDITION_END_DATE, (CONDITION_START_DATE + 1 * INTERVAL '1 day')) AS CONDITION_END_DATE

FROM omopcdm.CONDITION_OCCURRENCE co
WHERE co.CONDITION_CONCEPT_ID != 0;
/* / */
DROP TABLE IF EXISTS cteCondEndDates;
/* / */
CREATE TEMP TABLE cteCondEndDates
AS
SELECT PERSON_ID
     , CONDITION_CONCEPT_ID
     , (EVENT_DATE + - 30 * INTERVAL '1 day') AS END_DATE -- unpad the end date

FROM (
         SELECT E1.PERSON_ID
              , E1.CONDITION_CONCEPT_ID
              , E1.EVENT_DATE
              , COALESCE(E1.START_ORDINAL, MAX(E2.START_ORDINAL)) START_ORDINAL
              , E1.OVERALL_ORD
         FROM (
                  SELECT PERSON_ID
                       , CONDITION_CONCEPT_ID
                       , EVENT_DATE
                       , EVENT_TYPE
                       , START_ORDINAL
                       , ROW_NUMBER() OVER (
                      PARTITION BY PERSON_ID
                          ,CONDITION_CONCEPT_ID ORDER BY EVENT_DATE
                          ,EVENT_TYPE
                      ) AS OVERALL_ORD -- this re-numbers the inner UNION so all rows are numbered ordered by the event date
                  FROM (
                           -- select the start dates, assigning a row number to each
                           SELECT PERSON_ID
                                , CONDITION_CONCEPT_ID
                                , CONDITION_START_DATE AS EVENT_DATE
                                , - 1                  AS EVENT_TYPE
                                , ROW_NUMBER() OVER (
                               PARTITION BY PERSON_ID
                                   ,CONDITION_CONCEPT_ID ORDER BY CONDITION_START_DATE
                               )                       AS START_ORDINAL
                           FROM cteConditionTarget
                           UNION ALL
                           -- pad the end dates by 30 to allow a grace period for overlapping ranges.
                           SELECT PERSON_ID
                                , CONDITION_CONCEPT_ID
                                , (CONDITION_END_DATE + 30 * INTERVAL '1 day')
                                , 1 AS EVENT_TYPE
                                , NULL
                           FROM cteConditionTarget
                       ) RAWDATA
              ) E1
                  INNER JOIN (
             SELECT PERSON_ID
                  , CONDITION_CONCEPT_ID
                  , CONDITION_START_DATE AS EVENT_DATE
                  , ROW_NUMBER() OVER (
                 PARTITION BY PERSON_ID
                     ,CONDITION_CONCEPT_ID ORDER BY CONDITION_START_DATE
                 )                       AS START_ORDINAL
             FROM cteConditionTarget
         ) E2 ON E1.PERSON_ID = E2.PERSON_ID
             AND E1.CONDITION_CONCEPT_ID = E2.CONDITION_CONCEPT_ID
             AND E2.EVENT_DATE <= E1.EVENT_DATE
         GROUP BY E1.PERSON_ID
                , E1.CONDITION_CONCEPT_ID
                , E1.EVENT_DATE
                , E1.START_ORDINAL
                , E1.OVERALL_ORD
     ) E
WHERE (2 * E.START_ORDINAL) - E.OVERALL_ORD = 0;

/* / */
DROP TABLE IF EXISTS cteConditionEnds;
/* / */
CREATE TEMP TABLE cteConditionEnds
AS
SELECT c.PERSON_ID
     , c.CONDITION_CONCEPT_ID
     , c.CONDITION_START_DATE
     , MIN(e.END_DATE) AS ERA_END_DATE

FROM cteConditionTarget c
         INNER JOIN cteCondEndDates e ON c.PERSON_ID = e.PERSON_ID
    AND c.CONDITION_CONCEPT_ID = e.CONDITION_CONCEPT_ID
    AND e.END_DATE >= c.CONDITION_START_DATE
GROUP BY c.PERSON_ID
       , c.CONDITION_CONCEPT_ID
       , c.CONDITION_START_DATE;
/* / */
INSERT INTO omopcdm.condition_era ( condition_era_id
                                  , person_id
                                  , condition_concept_id
                                  , condition_era_start_date
                                  , condition_era_end_date
                                  , condition_occurrence_count)
SELECT row_number() OVER (
    ORDER BY person_id
    )                            AS condition_era_id
     , person_id
     , CONDITION_CONCEPT_ID
     , min(CONDITION_START_DATE) AS CONDITION_ERA_START_DATE
     , ERA_END_DATE              AS CONDITION_ERA_END_DATE
     , COUNT(*)                  AS CONDITION_OCCURRENCE_COUNT
FROM cteConditionEnds
GROUP BY person_id
       , CONDITION_CONCEPT_ID
       , ERA_END_DATE;

CREATE INDEX idx_drug_era_person_id_1 ON omopcdm.drug_era (person_id ASC);
CLUSTER omopcdm.drug_era USING idx_drug_era_person_id_1;
CREATE INDEX idx_drug_era_concept_id_1 ON omopcdm.drug_era (drug_concept_id ASC);

CREATE INDEX idx_dose_era_person_id_1 ON omopcdm.dose_era (person_id ASC);
CLUSTER omopcdm.dose_era USING idx_dose_era_person_id_1;
CREATE INDEX idx_dose_era_concept_id_1 ON omopcdm.dose_era (drug_concept_id ASC);

CREATE INDEX idx_condition_era_person_id_1 ON omopcdm.condition_era (person_id ASC);
CLUSTER omopcdm.condition_era USING idx_condition_era_person_id_1;
CREATE INDEX idx_condition_era_concept_id_1 ON omopcdm.condition_era (condition_concept_id ASC);

ALTER TABLE omopcdm.DRUG_ERA
    ADD CONSTRAINT xpk_DRUG_ERA PRIMARY KEY (drug_era_id);

ALTER TABLE omopcdm.DOSE_ERA
    ADD CONSTRAINT xpk_DOSE_ERA PRIMARY KEY (dose_era_id);

ALTER TABLE omopcdm.CONDITION_ERA
    ADD CONSTRAINT xpk_CONDITION_ERA PRIMARY KEY (condition_era_id);