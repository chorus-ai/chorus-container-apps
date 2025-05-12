SET search_path=omopcdm;
DROP TABLE IF EXISTS public.domain_summary_condition;
CREATE TABLE public.domain_summary_condition AS (

                                   SELECT concept.concept_id AS CONCEPT_ID,
                                          concept.concept_name AS CONCEPT_NAME,
                                          ar1.count_value                                     AS NUM_PERSONS,
                                          ROUND(1.0 * ar1.count_value / denom.count_value, 4) AS PERCENT_PERSONS,
                                          ROUND(1.0 * ar2.count_value / ar1.count_value, 1)   AS RECORDS_PER_PERSON,
                                          ntile(10) OVER (ORDER BY ar1.count_value / denom.count_value DESC) AS PERCENT_PERSONS_NTILE,
                                          ntile(10) OVER (ORDER BY 1.0 * ar2.count_value / ar1.count_value DESC) AS RECORDS_PER_PERSON_NTILE
                                   FROM (
                                            SELECT CAST(stratum_1 AS BIGINT) stratum_1, count_value
                                            FROM achilles_results
                                            WHERE analysis_id = 400
                                            GROUP BY analysis_id,
                                                     stratum_1,
                                                     count_value
                                        ) ar1
                                            INNER JOIN
                                        (
                                            SELECT CAST(stratum_1 AS BIGINT) stratum_1, count_value
                                            FROM achilles_results
                                            WHERE analysis_id = 401
                                            GROUP BY analysis_id,
                                                     stratum_1,
                                                     count_value
                                        ) ar2
                                        ON ar1.stratum_1 = ar2.stratum_1
                                            INNER JOIN
                                        (
                                            SELECT concept_id, concept_name
                                            FROM concept
                                            WHERE domain_id = 'Condition'
                                        ) concept
                                        ON concept.concept_id = ar1.stratum_1 AND concept.concept_id = ar2.stratum_1,
                                        (
                                            SELECT count_value
                                            FROM achilles_results
                                            WHERE analysis_id = 1
                                        ) denom
                                   ORDER BY ar1.count_value DESC
);