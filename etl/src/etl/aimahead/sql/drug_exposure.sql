WITH
    drug_exposure_joined AS (
        SELECT
            NULL::integer AS src_table_id,
            NULL::integer AS src_person_id,
            NULL::integer AS src_visit_occurrence_id,
            NULL::integer AS src_visit_detail_id,
            sk.s_key AS src_name,
            drug_exposure_id,
            person_id,
            drug_concept_id,
            drug_exposure_start_date,
            drug_exposure_start_datetime,
            drug_exposure_end_date,
            drug_exposure_end_datetime,
            verbatim_end_date,
            drug_type_concept_id,
            NULL AS stop_reason,
            refills,
            quantity,
            days_supply,
            NULL AS sig,
            route_concept_id,
            NULL AS lot_number,
            visit_occurrence_id,
            visit_detail_id,
            NULL AS drug_source_value,
            drug_source_concept_id,
            NULL AS route_source_value,
            NULL AS dose_unit_source_value
        FROM aimahead.drug_exposure de
        JOIN persist.source_key sk ON de.src_name = sk.s_name
        WHERE person_id IN (SELECT person_id FROM aimahead_60.person)
        AND drug_concept_id NOT IN (SELECT concept_id FROM persist.censored_concept)
    )
INSERT INTO
    aimahead_60.drug_exposure
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
