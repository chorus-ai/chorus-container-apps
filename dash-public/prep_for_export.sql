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
