DROP TABLE IF EXISTS public.all_metadata;

CREATE TABLE public.all_metadata(
    file_id integer,
    name text,
    container text,
    last_modified text,
    size text,
    creation_time text
);
