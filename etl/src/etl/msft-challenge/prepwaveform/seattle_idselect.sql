SELECT a.name,
       b.new_id
FROM public.seattle_allfiles a
    LEFT JOIN persist.person_map b
        ON a.person::bigint = b.old_id::bigint
WHERE extension IS NOT NULL
    AND extension = 'parq'
    AND b.source_name = 'seattle' ;