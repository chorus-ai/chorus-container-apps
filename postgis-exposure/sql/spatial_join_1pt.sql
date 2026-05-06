INSERT INTO working.external_exposure(external_exposure_id,
                                      location_id,
                                      person_id,
                                      exposure_concept_id,
                                      exposure_start_date,
                                      exposure_start_datetime,
                                      exposure_end_date,
                                      exposure_end_datetime,
                                      exposure_type_concept_id,
                                      exposure_relationship_concept_id,
                                      exposure_source_concept_id,
                                      exposure_source_value,
                                      exposure_relationship_source_value,
                                      dose_unit_source_value,
                                      quantity,
                                      modifier_source_value,
                                      operator_concept_id,
                                      value_as_number,
                                      value_as_concept_id,
                                      unit_concept_id,
                                      sdoh_data_year,
                                      sdoh_year_map_status)
select row_number() OVER() + (SELECT count(*) FROM working.external_exposure)
     , gol.location_id
     , gol.entity_id AS person_id
     , CASE
               WHEN NULLIF(att.attr_concept_id, '') ~ '^[-+]?[0-9]+([.][0-9]+)?$'
               THEN att.attr_concept_id::
    float::int
         ELSE 0
END
AS exposure_concept_id
     , gol.start_date                                                                  AS exposure_start_date
     , gol.start_date::timestamp                                                       AS exposure_start_datetime
     , gol.end_date                                                                    AS exposure_end_date
     , gol.end_date::timestamp                                                         AS exposure_end_datetime
     , 0                                                                             AS exposure_type_concept_id
     , 0                                                                             AS exposure_relationship_concept_id
     , NULL                                                                          AS exposure_source_concept_id
     , '@VAR_NAME'                                                                   AS exposure_source_value
     , CAST(NULL AS VARCHAR(50))                                                     AS exposure_relationship_source_value
     , CAST(NULL AS VARCHAR(50))                                                     AS dose_unit_source_value
     , CAST(NULL AS INTEGER)                                                         AS quantity
     , LEFT(gol.modifier_source_value, 50)                                           AS modifier_source_value
     , CAST(NULL AS INTEGER)                                                         AS operator_concept_id
      , CASE
             WHEN NULLIF(trim(geo.@VAR_COL::text), '') ~ '^[-+]?[0-9]+([.][0-9]+)?$'
                  THEN NULLIF(trim(geo.@VAR_COL::text), '')::numeric
             ELSE NULL
        END                                                                           AS value_as_number
      , CASE
             WHEN NULLIF(att.value_as_concept_id, '') ~ '^[-+]?[0-9]+([.][0-9]+)?$'
                  THEN att.value_as_concept_id::float::integer
             ELSE NULL
        END                                                                           AS value_as_concept_id
      , CASE
             WHEN NULLIF(att.unit_concept_id, '') ~ '^[-+]?[0-9]+([.][0-9]+)?$'
                  THEN att.unit_concept_id::float::integer
             ELSE NULL
        END                                                                           AS unit_concept_id
      , working.map_sdoh_year(
            att.dataset_type,
            EXTRACT(YEAR FROM gol.start_date)::integer
        )                                                                             AS sdoh_data_year
      , CASE
            WHEN working.map_sdoh_year(
                    att.dataset_type,
                    EXTRACT(YEAR FROM gol.start_date)::integer
                 ) IS NULL THEN 'not_applicable'
            WHEN working.map_sdoh_year(
                    att.dataset_type,
                    EXTRACT(YEAR FROM gol.start_date)::integer
                 ) = EXTRACT(YEAR FROM gol.start_date)::integer THEN 'exact_year'
            ELSE 'nearest_year'
        END                                                                           AS sdoh_year_map_status
from (SELECT *, 1 AS join_all FROM backbone.variable_source WHERE variable_source_id = @VAR_ID) att
         inner join ( SELECT @VAR_COL, wgs_geom, 1 AS join_all FROM public.@VAR_SRC) geo
                    on att.join_all = geo.join_all
         join working.location_merge gol
              on public.st_within(gol.geom, geo.wgs_geom)
           AND (
                (
                     working.map_sdoh_year(
                          att.dataset_type,
                          COALESCE(EXTRACT(YEAR FROM gol.start_date)::integer, EXTRACT(YEAR FROM gol.end_date)::integer)
                     ) IS NOT NULL
                     AND working.map_sdoh_year(
                          att.dataset_type,
                          COALESCE(EXTRACT(YEAR FROM gol.start_date)::integer, EXTRACT(YEAR FROM gol.end_date)::integer)
                     ) = EXTRACT(YEAR FROM att.attr_start_date::date)::integer
                )
                OR
                (
                     working.map_sdoh_year(
                          att.dataset_type,
                          COALESCE(EXTRACT(YEAR FROM gol.start_date)::integer, EXTRACT(YEAR FROM gol.end_date)::integer)
                     ) IS NULL
                     AND (
                          gol.start_date BETWEEN att.attr_start_date::date AND att.attr_end_date::date
                          OR gol.end_date BETWEEN att.attr_start_date::date AND att.attr_end_date::date
                          OR (gol.start_date <= att.attr_start_date::date AND gol.end_date >= att.attr_end_date::date)
                     )
                )
           );
