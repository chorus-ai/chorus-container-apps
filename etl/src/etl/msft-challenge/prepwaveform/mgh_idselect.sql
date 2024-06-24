SELECT a.name,
       b.new_id
FROM public.mgh_allfiles a
    INNER JOIN persist.person_map b
        ON a.person::bigint = b.old_id
WHERE extension IS NOT NULL
    AND extension = 'parquet'
    AND b.source_name = 'mgh' ;