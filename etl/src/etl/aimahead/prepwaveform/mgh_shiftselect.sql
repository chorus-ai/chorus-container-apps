SELECT a.name,
       concat(to_char(concat(split_part(filename, '_', 2), ' ',
                             split_part(filename, '_', 3))::TIMESTAMP + INTERVAL '1' DAY * C.days, 'YYYYmmDDHHmiSS'),
              '_',
              array_to_string(((string_to_array(filename, '_'))[4:]), '_')) AS modified_name
FROM public.mgh_allfiles a
         INNER JOIN persist.person_map b ON a.person::bigint = b.old_id
          INNER JOIN persist.date_shift C
ON b.new_id = C.person_id
WHERE extension IS NOT NULL AND extension <> 'csv' AND extension <> 'dcm' AND person != 'person711';