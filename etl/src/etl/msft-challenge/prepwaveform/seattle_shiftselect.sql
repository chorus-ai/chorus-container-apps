SELECT a.name,
       concat(to_char(concat(SUBSTRING(split_part(filename, '_', 2), 5, 4),
                              SUBSTRING(split_part(filename, '_', 2), 1, 2),
                              SUBSTRING(split_part(filename, '_', 2), 3, 2), ' ',
                              '120000') ::timestamp  + INTERVAL '1' DAY * C.days, 'YYYYmmDDHHmiSS'),
              '_',
              array_to_string(((string_to_array(filename, '_'))[4:]), '_')) AS modified_name
FROM public.seattle_allfiles a
         INNER JOIN persist.person_map b ON a.person::bigint = b.old_id::bigint
          INNER JOIN persist.date_shift C
ON b.new_id = C.person_id
WHERE extension IS NOT NULL
    AND extension = 'parq'
    AND b.source_name = 'seattle';