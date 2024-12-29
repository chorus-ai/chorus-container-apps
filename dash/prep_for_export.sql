DROP TABLE IF EXISTS public.all_metadata_expanded;

CREATE TABLE public.all_metadata_expanded AS (
SELECT     name,
           container,
           last_modified::timestamp AS last_modified,
           size::float AS size,
           creation_time::timestamp AS creation_time,
           date_part('year', last_modified::timestamp) AS year_modified,
           date_part('month', last_modified::timestamp) AS month_modified,
           FLOOR(((date_part('month', last_modified::timestamp)-1) / 3) + 1) AS quarter_modified,
           date_part('year', creation_time::timestamp) AS year_created,
           date_part('month', creation_time::timestamp) AS month_created,
           FLOOR(((date_part('month', creation_time::timestamp)-1) / 3) + 1) AS quarter_created,
           CASE WHEN char_length(split_part(name,'.', -1)) < 10 THEN split_part(name,'.', -1) END AS extension,
           CASE WHEN lower(name) LIKE '%note%' OR lower(name) LIKE 'note%' THEN 'NOTE'
                WHEN lower(name) LIKE '%omop%' OR lower(name) LIKE 'omop%' OR split_part(name,'.', -1) = 'csv' OR split_part(name,'.', -1) = 'xlsx' THEN 'OMOP'
                WHEN lower(name) LIKE '%wave%' OR lower(name) LIKE 'wave%' THEN 'WAVE'
                WHEN lower(name) LIKE '%image%' OR lower(name) LIKE 'image%' THEN 'IMAGE'
           END AS mode,
           CURRENT_TIMESTAMP AS loaded_at
    FROM public.all_metadata WHERE size::float > 0
);

DROP TABLE IF EXISTS public.by_site_metadata;

CREATE TABLE public.by_site_metadata AS (
WITH  bs_tmp AS (
    SELECT container,
           sum(size) filter (WHERE mode = 'OMOP')  AS OMOP_SIZE,
           sum(size) filter (WHERE mode = 'WAVE')  AS WAVE_SIZE,
           sum(size) filter (WHERE mode = 'IMAGE')  AS IMAGE_SIZE,
           sum(size) filter (WHERE mode = 'NOTE')  AS NOTE_SIZE,
           (SELECT sum(size) FROM public.all_metadata_expanded) AS TOTAL_SIZE,
           count(*) filter (WHERE mode = 'OMOP')  AS OMOP_FILES,
           count(*) filter (WHERE mode = 'WAVE')  AS WAVE_FILES,
           count(*) filter (WHERE mode = 'IMAGE')  AS IMAGE_FILES,
           count(*) filter (WHERE mode = 'NOTE')  AS NOTE_FILES,
           ARRAY_AGG(DISTINCT(extension)) filter (WHERE mode = 'WAVE') AS WAVEFORM_EXT,
           ARRAY_AGG(DISTINCT(extension)) filter (WHERE mode = 'IMAGE') AS IMAGE_EXT,
           MAX(last_modified) AS MOST_RECENT_UPLOAD,
           MAX(last_modified)  filter (WHERE mode = 'OMOP')  AS MOST_RECENT_OMOP,
           MAX(last_modified)  filter (WHERE mode = 'WAVE')  AS MOST_RECENT_WAVE,
           MAX(last_modified)  filter (WHERE mode = 'IMAGE')  AS MOST_RECENT_IMAGE,
           MAX(last_modified)  filter (WHERE mode = 'NOTE')  AS MOST_RECENT_NOTE,
           MAX(loaded_at) AS LOADED_AT
    FROM public.all_metadata_expanded
    GROUP BY container)
    SELECT container,
           COALESCE(ROUND(OMOP_SIZE::numeric/1000000000, 2), 0) AS OMOP_SIZE,
           COALESCE(ROUND(WAVE_SIZE::numeric/1000000000, 2), 0) AS WAVE_SIZE,
           COALESCE(ROUND(IMAGE_SIZE::numeric/1000000000, 2), 0) AS IMAGE_SIZE,
           COALESCE(ROUND(NOTE_SIZE::numeric/1000000000, 2), 0) AS NOTE_SIZE,
           OMOP_FILES,
           WAVE_FILES,
           IMAGE_FILES,
           NOTE_FILES,
           ARRAY_TO_STRING(WAVEFORM_EXT, ';') AS WAVEFORM_EXT,
           ARRAY_TO_STRING(IMAGE_EXT, ';') AS IMAGE_EXT,
           MOST_RECENT_UPLOAD,
           COALESCE(ROUND(((OMOP_SIZE / TOTAL_SIZE) * 100)::numeric, 2), 0) AS OMOP_REL,
           COALESCE(ROUND(((WAVE_SIZE / TOTAL_SIZE) * 100)::numeric, 2), 0) AS WAVEFORM_REL,
           COALESCE(ROUND(((IMAGE_SIZE / TOTAL_SIZE) * 100)::numeric, 2), 0) AS IMAGE_REL,
           COALESCE(ROUND(((NOTE_SIZE / TOTAL_SIZE) * 100)::numeric, 2), 0) AS NOTE_REL,
           MOST_RECENT_OMOP,
           MOST_RECENT_WAVE,
           MOST_RECENT_IMAGE,
           MOST_RECENT_NOTE,
           LOADED_AT
    FROM bs_tmp
);

DROP TABLE IF EXISTS public.all_metadata_sample;

CREATE TABLE public.all_metadata_sample AS (
WITH am_sample AS (
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'columbia' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'columbia' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'columbia' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'columbia' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'duke' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'duke' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'duke' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'duke' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'emory' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'emory' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'emory' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'emory' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mayo' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mayo' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mayo' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mayo' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mgh' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mgh' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mgh' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mgh' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mit' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mit' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mit' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'mit' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'nationwide' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'nationwide' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'nationwide' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'nationwide' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'pitts' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'pitts' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'pitts' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'pitts' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'seattle' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'seattle' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'seattle' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'seattle' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'tuft' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'tuft' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'tuft' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'tuft' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'ucla' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'ucla' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'ucla' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'ucla' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'ucsf' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'ucsf' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'ucsf' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'ucsf' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'uflorida' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'uflorida' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'uflorida' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'uflorida' AND mode = 'NOTE' LIMIT 1000)
    UNION
    --
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'uva' AND mode = 'OMOP' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'uva' AND mode = 'WAVE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'uva' AND mode = 'IMAGE' LIMIT 1000)
    UNION
    (SELECT * FROM public.all_metadata_expanded
    WHERE container = 'uva' AND mode = 'NOTE' LIMIT 1000)
                  )
SELECT * FROM am_sample
);
