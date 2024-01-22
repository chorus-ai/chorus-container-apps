WITH
    specimen_joined AS (
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'columbia' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            columbia.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'columbia'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'duke' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            duke.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'duke'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'emory' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            emory.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'emory'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'mgh' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            mgh.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'mgh'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'mit' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            mit.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'mit'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'mayo' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            mayo.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'mayo'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'nationwide' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            nationwide.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'nationwide'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'newmexico' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            newmexico.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'newmexico'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'ucla' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            ucla.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'ucla'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'ucsf' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            ucsf.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'ucsf'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'florida' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            florida.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'florida'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'pittsburgh' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            pittsburgh.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'pittsburgh'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'virginia' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            virginia.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'virginia'
        UNION
        SELECT
            specimen_id AS src_table_id,
            person_id AS src_person_id,
            'seattle' AS src_name,
            specimen_concept_id,
            specimen_type_concept_id,
            specimen_date,
            specimen_datetime,
            quantity,
            unit_concept_id,
            anatomic_site_concept_id,
            disease_status_concept_id,
            specimen_source_id,
            specimen_source_value,
            unit_source_value,
            anatomic_site_source_value,
            disease_status_source_value
        FROM
            seattle.specimen s
        INNER JOIN person_map pm
                ON pm.old_id = s.person_id
        WHERE pm.source_name = 'seattle'
    )
INSERT INTO
    specimen
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) AS specimen_id,
    person_id,
    specimen_concept_id,
    specimen_type_concept_id,
    specimen_date,
    specimen_datetime,
    quantity,
    unit_concept_id,
    anatomic_site_concept_id,
    disease_status_concept_id,
    specimen_source_id,
    specimen_source_value,
    unit_source_value,
    anatomic_site_source_value,
    disease_status_source_value,
    src_table_id,
    src_person_id,
    src_name
FROM
    specimen_joined;
