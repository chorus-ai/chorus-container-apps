SELECT a.name,
       concat(to_char(to_timestamp(split_part(filename, '_', 2)::bigint) + INTERVAL '1' DAY * C.days, 'YYYYmmDDHHmiSS'),
              '_',
              array_to_string(((string_to_array(filename, '_'))[4:]), '_')) AS modified_name
FROM public.nationwide_allfiles a
         INNER JOIN persist.person_map b ON a.person::bigint = b.old_id::bigint
          INNER JOIN persist.date_shift C
ON b.new_id = C.person_id
WHERE extension IS NOT NULL
    AND extension = 'gzip'
    AND b.source_name = 'nationwide';