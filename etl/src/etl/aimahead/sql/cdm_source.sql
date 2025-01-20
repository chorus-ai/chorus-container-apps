INSERT INTO
    aimahead_60.cdm_source (
        cdm_source_name,
        cdm_source_abbreviation,
        cdm_holder,
        source_description,
        source_documentation_reference,
        cdm_etl_reference,
        source_release_date,
        cdm_release_date,
        cdm_version,
        cdm_version_concept_id,
        vocabulary_version
    )
SELECT
    'AIMAHEAD-60' AS cdm_source_name,
    'AIMAHEAD-60' AS cdm_source_abbreviation,
    'CHoRUS' AS cdm_holder,
    NULL AS source_description,
    NULL AS source_documentation_reference,
    'https://github.com/chorus-ai/chorus-container-apps' AS cdm_etl_reference,
    CURRENT_DATE AS source_release_date,
    CURRENT_DATE AS cdm_release_date,
    'v5.4.0' AS cdm_version,
    756265
    /* OMOP CDM Version 5.4.0 */
    AS cdm_version_concept_id,
    (SELECT vocabulary_version FROM vocabulary.vocabulary WHERE vocabulary_id = 'None') AS vocabulary_version;