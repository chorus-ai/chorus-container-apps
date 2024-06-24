SELECT b.merge_id,
       a.name,
       CASE WHEN extension = 'RECORDS' THEN
       concat(split_part(a.name, '/', 3), '_',
               to_char(b.start_time + INTERVAL '1' DAY * COALESCE(C.days, 0), 'YYYYmmDDHHmiSS'),
              '_RECORDS')
       WHEN (array_length((string_to_array(filename, '_')), 1) > 1) THEN
       concat(split_part(a.name, '/', 3), '_',
               to_char(b.start_time + INTERVAL '1' DAY * COALESCE(C.days, 0), 'YYYYmmDDHHmiSS'),
              '_',
              array_to_string((string_to_array(filename, '_'))[2:], '_'))
       ELSE
        concat(split_part(split_part(a.name, '/', 4), '.', 1), '_',
              to_char(b.start_time + INTERVAL '1' DAY * COALESCE(C.days, 0), 'YYYYmmDDHHmiSS'),
              '_main.',
              split_part(split_part(a.name, '/', 4), '.', 2))
        END AS modified_name
FROM public.mit_allfiles a
      INNER JOIN public.mit_wave_tmp b
          ON a.person::bigint = b.merge_id
	  LEFT JOIN persist.date_shift C
          ON b.merge_id = C.person_id
WHERE extension IS NOT NULL
    AND extension <> 'csv'
ORDER BY random()
LIMIT 100;