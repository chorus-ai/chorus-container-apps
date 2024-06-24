-- Note that the person column for MIT is updated with the merge identity so no person_map join is needed
SELECT a.person::integer, a.name
FROM public.mit_allfiles a
WHERE extension IS NOT NULL
  AND extension <> 'csv'
  AND extension <> 'RECORDS';