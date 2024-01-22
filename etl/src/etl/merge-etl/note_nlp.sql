WITH
    note_nlp_joined AS (
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'columbia' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            columbia.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'columbia'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'duke' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            duke.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'duke'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'emory' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            emory.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'emory'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'mgh' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            mgh.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'mgh'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'mit' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            mit.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'mit'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'mayo' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            mayo.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'mayo'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'nationwide' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            nationwide.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'nationwide'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'newmexico' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            newmexico.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'newmexico'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'ucla' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            ucla.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'ucla'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'ucsf' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            ucsf.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'ucsf'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'florida' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            florida.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'florida'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'pittsburgh' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            pittsburgh.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'pittsburgh'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'virginia' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            virginia.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'virginia'
        UNION
        SELECT
            note_nlp_id  AS src_table_id,
            note_id AS src_note_id,
            'seattle' AS src_name,
            nm.new_id AS note_id,
            section_concept_id,
            snippet,
            offset,
            lexical_variant,
            note_nlp_concept_id,
            note_nlp_source_concept_id,
            nlp_system,
            nlp_date,
            nlp_datetime,
            term_exists,
            term_temporal,
            term_modifiers
        FROM
            seattle.note_nlp n
        INNER JOIN note_map nm
                ON nm.old_id = n.note_id
        WHERE nm.source_name = 'seattle'
    )
INSERT INTO
    note_nlp
SELECT
    row_number() OVER (ORDER BY src_name, src_table_id) AS note_nlp_id,
    note_id,
    section_concept_id,
    snippet,
    offset,
    lexical_variant,
    note_nlp_concept_id,
    note_nlp_source_concept_id,
    nlp_system,
    nlp_date,
    nlp_datetime,
    term_exists,
    term_temporal,
    term_modifiers,
    src_table_id,
    src_note_id,
    src_name
FROM
    note_nlp_joined;
