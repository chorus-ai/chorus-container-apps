-- Note that the person column for MIT is updated with the merge identity so no person_map join is needed
SELECT a.record_id,
       a.merge_id
FROM public.mit_wave_tmp a;