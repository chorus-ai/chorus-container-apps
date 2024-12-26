WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'columbia' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            columbia.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'columbia'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'duke' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            duke.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'duke'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'emory' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            emory.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'emory'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'mgh' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            mgh.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'mgh'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'mit' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            mit.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'mit'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'mayo' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            mayo.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'mayo'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'nationwide' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            nationwide.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'nationwide'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'newmexico' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            newmexico.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'newmexico'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'ucla' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            ucla.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'ucla'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'ucsf' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            ucsf.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'ucsf'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'florida' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            florida.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'florida'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'pittsburgh' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            pittsburgh.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'pittsburgh'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'virginia' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            virginia.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'virginia'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'seattle' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            seattle.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'seattle'
        )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
    

WITH
    person_joined AS (
        SELECT
            person_id AS src_person_id,
            'tufts' AS src_name,
            new_id AS person_id,
            gender_concept_id,
            year_of_birth,
            month_of_birth,
            day_of_birth,
            birth_datetime,
            race_concept_id,
            ethnicity_concept_id,
            person_source_value,
            gender_source_value,
            gender_source_concept_id,
            race_source_value,
            race_source_concept_id,
            ethnicity_source_value,
            ethnicity_source_concept_id
        FROM
            tufts.person p
        INNER JOIN persist.person_map pm
                ON pm.old_id = p.person_id
        WHERE pm.source_name = 'tufts'
    )
INSERT INTO
    person
SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id,
    src_person_id,
    src_name
FROM
    person_joined;
