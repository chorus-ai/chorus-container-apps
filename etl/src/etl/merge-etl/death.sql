WITH
    death_joined AS (
        SELECT
            person_id AS src_person_id,
            'columbia' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            columbia.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'columbia'
        UNION
        SELECT
            person_id AS src_person_id,
            'duke' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            duke.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'duke'
        UNION
        SELECT
            person_id AS src_person_id,
            'emory' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            emory.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'emory'
        UNION
        SELECT
            person_id AS src_person_id,
            'mgh' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            mgh.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'mgh'
        UNION
        SELECT
            person_id AS src_person_id,
            'mit' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            mit.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'mit'
        UNION
        SELECT
            person_id AS src_person_id,
            'mayo' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            mayo.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'mayo'
        UNION
        SELECT
            person_id AS src_person_id,
            'nationwide' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            nationwide.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'nationwide'
        UNION
        SELECT
            person_id AS src_person_id,
            'newmexico' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            newmexico.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'newmexico'
        UNION
        SELECT
            person_id AS src_person_id,
            'ucla' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            ucla.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'ucla'
        UNION
        SELECT
            person_id AS src_person_id,
            'ucsf' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            ucsf.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'ucsf'
        UNION
        SELECT
            person_id AS src_person_id,
            'florida' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            florida.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'florida'
        UNION
        SELECT
            person_id AS src_person_id,
            'pittsburgh' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            pittsburgh.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'pittsburgh'
        UNION
        SELECT
            person_id AS src_person_id,
            'virginia' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            virginia.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'virginia'
        UNION
        SELECT
            person_id AS src_person_id,
            'seattle' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            seattle.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'seattle'
        UNION
        SELECT
            person_id AS src_person_id,
            'tufts' AS src_name,
            pm.new_id AS person_id,
            death_date,
            death_datetime,
            death_type_concept_id,
            cause_concept_id,
            cause_source_value,
            cause_source_concept_id
        FROM
            tufts.death de
        INNER JOIN persist.person_map pm
                ON pm.old_id = de.person_id
        WHERE pm.source_name = 'tufts'
    )
INSERT INTO
    death
SELECT
    person_id,
    death_date,
    death_datetime,
    death_type_concept_id,
    cause_concept_id,
    cause_source_value,
    cause_source_concept_id,
    src_person_id,
    src_name
FROM
    death_joined;
    
