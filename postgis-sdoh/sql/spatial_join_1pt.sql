INSERT INTO working.external_exposure
select gol.location_id
     , CAST(NULL AS INTEGER)                                                         AS person_id
     , CASE
         WHEN att.attr_concept_id IS NOT NULL
             THEN att.attr_concept_id::float::int
         ELSE 0
         END                                                                         AS exposure_concept_id
     , att.attr_start_date                                                           AS exposure_start_date
     , att.attr_start_date                                                           AS exposure_start_datetime
     , att.attr_end_date                                                             AS exposure_end_date
     , att.attr_end_date                                                             AS exposure_end_datetime
     , 0                                                                             AS exposure_type_concept_id
     , 0                                                                             AS exposure_relationship_concept_id
     , NULL                                                                          AS exposure_source_concept_id
     , '@VAR_NAME'                                                                   AS exposure_source_value
     , CAST(NULL AS VARCHAR(50))                                                     AS exposure_relationship_source_value
     , CAST(NULL AS VARCHAR(50))                                                     AS dose_unit_source_value
     , CAST(NULL AS INTEGER)                                                         AS quantity
     , CAST(NULL AS VARCHAR(50))                                                     AS modifier_source_value
     , CAST(NULL AS INTEGER)                                                         AS operator_concept_id
     , geo.@VAR_NAME                                                                 AS value_as_number -- Key column here!
     , att.value_as_concept_id                                                       AS value_as_concept_id
     , att.unit_concept_id                                                           AS unit_concept_id
from (SELECT *, 1 AS join_all FROM backbone.variable_source WHERE variable_name= '@VAR_NAME') att
         inner join ( SELECT a.@VAR_NAME, b.wgs_geom, 1 AS join_all FROM public.@VAR_SRC) geo
                    on att.join_all = geo.join_all
         join working.location_merge gol
              on public.st_within(gol.geom, geo.wgs_geom);