SELECT a.name,
       b.new_id
FROM public.nationwide_allfiles a
    LEFT JOIN persist.person_map b
        ON a.person::bigint = b.old_id::bigint
WHERE extension IS NOT NULL
    AND extension = 'gzip'
    AND b.source_name = 'nationwide' ;