DROP TABLE IF EXISTS public.allfiles;
CREATE TABLE public.allfiles AS (SELECT * FROM public.all_metadata_expanded);
ALTER TABLE public.allfiles ADD COLUMN person text;
ALTER TABLE public.allfiles RENAME COLUMN mode TO modality;
-- logic to extract unique persons by finding parent directory of waveform(s)/image(s)
UPDATE public.allfiles
SET person = CASE
       WHEN name ~* '.*/waveforms?/.*' THEN
           (regexp_match(name, '([^/]+)/waveforms?/', 'i'))[1]
       WHEN name ~* '.*/images?/.*' THEN
           (regexp_match(name, '([^/]+)/images?/', 'i'))[1]
       ELSE NULL
       END
WHERE name IS NOT NULL;

INSERT INTO public.allfiles (container, modality) SELECT distinct(container), 'WAVE' FROM public.allfiles;
INSERT INTO public.allfiles (container, modality) SELECT distinct(container), 'IMAGE' FROM public.allfiles;
INSERT INTO public.allfiles (container, modality) SELECT distinct(container), 'NOTE' FROM public.allfiles;
INSERT INTO public.allfiles (container, modality) SELECT distinct(container), 'OMOP' FROM public.allfiles;

DROP TABLE IF EXISTS public.allfiles_grouped;
CREATE TABLE public.allfiles_grouped AS (
select CEIL(COALESCE(sum(size),0)/1000000000)  as total_size_gb,
       CASE WHEN count(*) = 1 THEN 0
	   ELSE count(*) END AS total_files,
	   CASE WHEN modality in ('OMOP', 'NOTE') THEN NULL
	        ELSE COALESCE(count(distinct(person)), 0) END AS total_individuals,
	   container as src_container,
	   CASE WHEN container = 'tuft' THEN 'tufts'
	        WHEN container = 'pitts' THEN 'pittsburgh'
			WHEN container = 'uflorida' THEN 'florida'
			WHEN container = 'uva' THEN 'virginia'
			ELSE container END AS trg_container,
	   modality FROM public.allfiles where modality in ('WAVE', 'IMAGE', 'OMOP', 'NOTE') group by modality, container
	   );