WITH
    drug_exposure_joined AS (
        SELECT
            NULL::integer AS src_table_id,
            NULL::integer AS src_person_id,
            NULL::integer AS src_visit_occurrence_id,
            NULL::integer AS src_visit_detail_id,
            CASE WHEN src_name = 'mgh' THEN '1'
                   WHEN src_name = 'mit' THEN '2'
                   WHEN src_name = 'nationwide' THEN '3'
                   WHEN src_name = 'pittsburgh' THEN '4'
                   WHEN src_name = 'seattle' THEN '5'
              END AS src_name,
            drug_exposure_id,
            person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            stop_reason,
            refills,
            quantity,
            days_supply,
            NULL AS sig,
            route_concept_id,
            lot_number,
            visit_occurrence_id,
            visit_detail_id,
            NULL AS drug_source_value,
            drug_source_concept_id,
            NULL AS route_source_value,
            NULL AS dose_unit_source_value
        FROM msft_challenge.drug_exposure de
        WHERE person_id IN (SELECT person_id FROM msft_challenge_80.person)
    )
INSERT INTO
    msft_challenge_80.drug_exposure
SELECT
    drug_exposure_id,
    person_id,
    drug_concept_id,
    drug_exposure_start_date,
    drug_exposure_start_datetime,
    drug_exposure_end_date,
    drug_exposure_end_datetime,
    verbatim_end_date,
    drug_type_concept_id,
    stop_reason,
    refills,
    quantity,
    days_supply,
    sig,
    route_concept_id,
    lot_number,
    NULL AS provider_id,
    visit_occurrence_id,
    visit_detail_id,
    drug_source_value,
    drug_source_concept_id,
    route_source_value,
    dose_unit_source_value,
    src_table_id,
    src_person_id,
    src_visit_occurrence_id,
    src_visit_detail_id,
    src_name
FROM
    drug_exposure_joined;
