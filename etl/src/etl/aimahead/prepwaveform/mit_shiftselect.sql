SELECT a.record_id,
       concat(a.record_id, '_',
              to_char(a.start_time + INTERVAL '1' DAY * COALESCE(c.days, 0), 'YYYYmmDDHHmiSS')
       )
       AS modified_name
FROM public.mit_wave_tmp a
	  LEFT JOIN persist.date_shift C
          ON a.merge_id = C.person_id
;