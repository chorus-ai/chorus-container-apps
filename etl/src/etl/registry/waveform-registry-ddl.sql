CREATE TABLE public.waveform_reg
(
    file_id                 INTEGER,
    person_id               BIGINT,
    group_id                TEXT,
    visit_occurrence_id     BIGINT,
    file_datetime           TIMESTAMP,
    src_file                TEXT,
    trg_file                TEXT,
    src_person_id           BIGINT,
    src_name                TEXT,
    src_file_id             INTEGER,
    src_file_datetime       TIMESTAMP,
    src_visit_occurrence_id BIGINT
);