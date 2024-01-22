CREATE TABLE drug_era_all AS
WITH
    ctepredrugtarget AS (
        -- normalize drug_exposure_end_date to either the existing drug exposure end date, or add days supply, or add 1 day to the start date
        SELECT
            d.drug_exposure_id,
            d.person_id,
            c.concept_id               AS ingredient_concept_id,
            d.drug_exposure_start_date AS drug_exposure_start_date,
            d.days_supply              AS days_supply,
            COALESCE(
                ---nullif returns null if both values are the same, otherwise it returns the first parameter
                NULLIF(drug_exposure_end_date, NULL),
                ---if drug_exposure_end_date != null, return drug_exposure_end_date, otherwise go to next case
                NULLIF(dateadd (DAY, days_supply, drug_exposure_start_date), drug_exposure_start_date),
                ---if days_supply != null or 0, return drug_exposure_start_date + days_supply, otherwise go to next case
                dateadd (DAY, 1, drug_exposure_start_date)
                ---add 1 day to the drug_exposure_start_date since there is no end_date or interval for the days_supply
            ) AS drug_exposure_end_date
        FROM
            drug_exposure d
            JOIN concept_ancestor ca ON ca.descendant_concept_id = d.drug_concept_id
            JOIN concept c ON ca.ancestor_concept_id = c.concept_id
        WHERE
            LOWER(c.vocabulary_id) = 'rxnorm' ---8 selects rxnorm from the vocabulary_id
            AND LOWER(c.concept_class_id) = 'ingredient'
            AND d.drug_concept_id != 0 ---our unmapped drug_concept_id's are set to 0, so we don't want different drugs wrapped up in the same era
            AND COALESCE(d.days_supply, 0) >= 0 ---we have cases where days_supply is negative, and this can set the end_date before the start_date, which we don't want. so we're just looking over those rows. this is a data-quality issue.
    ),
    ctesubexposureenddates AS (
        --- a preliminary sorting that groups all of the overlapping exposures into one exposure so that we don't double-count non-gap-days
        SELECT
            person_id,
            ingredient_concept_id,
            event_date            AS end_date
        FROM
            (
                SELECT
                    person_id,
                    ingredient_concept_id,
                    event_date,
                    event_type,
                    MAX(start_ordinal) OVER (
                        PARTITION BY
                            person_id,
                            ingredient_concept_id
                        ORDER BY
                            event_date,
                            event_type ROWS UNBOUNDED PRECEDING
                    ) AS start_ordinal,
                    -- this pulls the current start down from the prior rows so that the nulls
                    -- from the end dates will contain a value we can compare with
                    ROW_NUMBER() OVER (
                        PARTITION BY
                            person_id,
                            ingredient_concept_id
                        ORDER BY
                            event_date,
                            event_type
                    ) AS overall_ord
                    -- this re-numbers the inner union so all rows are numbered ordered by the event date
                FROM
                    (
                        -- select the start dates, assigning a row number to each
                        SELECT
                            person_id,
                            ingredient_concept_id,
                            drug_exposure_start_date AS event_date,
                            -1                       AS event_type,
                            ROW_NUMBER() OVER        (
                                PARTITION BY
                                    person_id,
                                    ingredient_concept_id
                                ORDER BY
                                    drug_exposure_start_date
                            ) AS start_ordinal
                        FROM
                            ctepredrugtarget
                        UNION ALL
                        SELECT
                            person_id,
                            ingredient_concept_id,
                            drug_exposure_end_date,
                            1                      AS event_type,
                            NULL
                        FROM
                            ctepredrugtarget
                    ) rawdata
            ) e
        WHERE
            (2 * e.start_ordinal) - e.overall_ord = 0
    ),
    ctedrugexposureends AS (
        SELECT
            dt.person_id,
            dt.ingredient_concept_id,
            dt.drug_exposure_start_date,
            MIN(e.end_date)             AS drug_sub_exposure_end_date
        FROM
            ctepredrugtarget dt
            JOIN ctesubexposureenddates e ON dt.person_id = e.person_id
            AND dt.ingredient_concept_id = e.ingredient_concept_id
            AND e.end_date >= dt.drug_exposure_start_date
        GROUP BY
            dt.drug_exposure_id,
            dt.person_id,
            dt.ingredient_concept_id,
            dt.drug_exposure_start_date
    ),
    --------------------------------------------------------------------------------------------------------------
    ctesubexposures AS (
        SELECT
            ROW_NUMBER() OVER (
                PARTITION BY
                    person_id,
                    ingredient_concept_id,
                    drug_sub_exposure_end_date
                ORDER BY
                    person_id
            ) AS rn,
            person_id,
            ingredient_concept_id,
            MIN(drug_exposure_start_date) AS drug_sub_exposure_start_date,
            drug_sub_exposure_end_date,
            COUNT(*) AS drug_exposure_count
        FROM
            ctedrugexposureends
        GROUP BY
            person_id,
            ingredient_concept_id,
            drug_sub_exposure_end_date
            --order by person_id, drug_concept_id
    ),
    --------------------------------------------------------------------------------------------------------------
    /*everything above grouped exposures into sub_exposures if there was overlap between exposures.
     *so there was no persistence window. now we can add the persistence window to calculate eras.
     */
    --------------------------------------------------------------------------------------------------------------
    ctefinaltarget AS (
        SELECT
            rn,
            person_id,
            ingredient_concept_id,
            drug_sub_exposure_start_date,
            drug_sub_exposure_end_date,
            drug_exposure_count,
            DATEDIFF(DAY, drug_sub_exposure_start_date, drug_sub_exposure_end_date) AS days_exposed
        FROM
            ctesubexposures
    ),
    cteenddates AS -- the magic
    (
        SELECT
            person_id,
            ingredient_concept_id,
            dateadd (DAY, -30, event_date) AS end_date -- unpad the end date
        FROM
            (
                SELECT
                    person_id,
                    ingredient_concept_id,
                    event_date,
                    event_type,
                    MAX(start_ordinal) OVER (
                        PARTITION BY
                            person_id,
                            ingredient_concept_id
                        ORDER BY
                            event_date,
                            event_type ROWS UNBOUNDED PRECEDING
                    ) AS start_ordinal,
                    -- this pulls the current start down from the prior rows so that the nulls
                    -- from the end dates will contain a value we can compare with
                    ROW_NUMBER() OVER (
                        PARTITION BY
                            person_id,
                            ingredient_concept_id
                        ORDER BY
                            event_date,
                            event_type
                    ) AS overall_ord
                    -- this re-numbers the inner union so all rows are numbered ordered by the event date
                FROM
                    (
                        -- select the start dates, assigning a row number to each
                        SELECT
                            person_id,
                            ingredient_concept_id,
                            drug_sub_exposure_start_date AS event_date,
                            -1                           AS event_type,
                            ROW_NUMBER() OVER            (
                                PARTITION BY
                                    person_id,
                                    ingredient_concept_id
                                ORDER BY
                                    drug_sub_exposure_start_date
                            ) AS start_ordinal
                        FROM
                            ctefinaltarget
                        UNION ALL
                        -- pad the end dates by 30 to allow a grace period for overlapping ranges.
                        SELECT
                            person_id,
                            ingredient_concept_id,
                            dateadd (DAY, 30,     drug_sub_exposure_end_date),
                            1                     AS event_type,
                            NULL
                        FROM
                            ctefinaltarget
                    ) rawdata
            ) e
        WHERE
            (2 * e.start_ordinal) - e.overall_ord = 0
    ),
    ctedrugeraends AS (
        SELECT
            ft.person_id,
            ft.ingredient_concept_id,
            ft.drug_sub_exposure_start_date,
            MIN(e.end_date)                 AS era_end_date,
            drug_exposure_count,
            days_exposed
        FROM
            ctefinaltarget ft
            JOIN cteenddates e ON ft.person_id = e.person_id
            AND ft.ingredient_concept_id = e.ingredient_concept_id
            AND e.end_date >= ft.drug_sub_exposure_start_date
        GROUP BY
            ft.person_id,
            ft.ingredient_concept_id,
            ft.drug_sub_exposure_start_date,
            drug_exposure_count,
            days_exposed
    )
SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            person_id
    ) drug_era_id,
    person_id,
    ingredient_concept_id AS drug_concept_id,
    MIN(drug_sub_exposure_start_date) AS drug_era_start_date,
    era_end_date AS drug_era_end_date,
    SUM(drug_exposure_count) AS drug_exposure_count,
    DATEDIFF(DAY, MIN(drug_sub_exposure_start_date), era_end_date) - SUM(days_exposed) AS gap_days
FROM
    ctedrugeraends dee
GROUP BY
    person_id,
    ingredient_concept_id,
    era_end_date;


INSERT INTO
    drug_era
SELECT
    CAST(drug_era_id AS integer)         AS drug_era_id,
    CAST(person_id AS integer)           AS person_id,
    CAST(drug_concept_id AS integer)     AS drug_concept_id,
    CAST(drug_era_start_date AS DATE)    AS drug_era_start_date,
    CAST(drug_era_end_date AS DATE)      AS drug_era_end_date,
    CAST(drug_exposure_count AS integer) AS drug_exposure_count,
    CAST(gap_days AS integer)            AS gap_days
FROM
    drug_era_all;