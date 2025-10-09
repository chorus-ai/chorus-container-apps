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
                                      unit_concept_id)
select row_number() OVER() + (SELECT count(*) FROM working.external_exposure)
     , gol.location_id
     , CASE
           WHEN gol.domain_id = 1147314
               THEN gol.entity_id
           ELSE 0
    END AS person_id
     , CASE
           WHEN att.attr_concept_id IS NOT NULL
               THEN att.attr_concept_id::
    float::int
         ELSE 0
END
AS exposure_concept_id
     , GREATEST(att.attr_start_date::date,gol.start_date)                            AS exposure_start_date
     , GREATEST(att.attr_start_date::timestamp,gol.start_date::timestamp)            AS exposure_start_datetime
     , LEAST(att.attr_end_date::date, gol.end_date)                                  AS exposure_end_date
     , LEAST(att.attr_end_date::timestamp, gol.end_date::timestamp)                  AS exposure_end_datetime
     , 0                                                                             AS exposure_type_concept_id
     , 0                                                                             AS exposure_relationship_concept_id
     , NULL                                                                          AS exposure_source_concept_id
     , '@VAR_NAME'                                                                   AS exposure_source_value
     , CAST(NULL AS VARCHAR(50))                                                     AS exposure_relationship_source_value
     , CAST(NULL AS VARCHAR(50))                                                     AS dose_unit_source_value
     , CAST(NULL AS INTEGER)                                                         AS quantity
     , CAST(NULL AS VARCHAR(50))                                                     AS modifier_source_value
     , CAST(NULL AS INTEGER)                                                         AS operator_concept_id
     , geo.@VAR_NAME::numeric                                                        AS value_as_number -- Key column here!
     , att.value_as_concept_id::float::integer                                       AS value_as_concept_id
     , att.unit_concept_id::float::integer                                           AS unit_concept_id
from (SELECT *, 1 AS join_all FROM backbone.variable_source WHERE variable_name= '@VAR_NAME') att
         inner join ( SELECT @VAR_NAME, wgs_geom, 1 AS join_all FROM public.@VAR_SRC) geo
                    on att.join_all = geo.join_all
         join working.location_merge gol
              on public.st_within(gol.geom, geo.wgs_geom)
         AND (gol.start_date BETWEEN att.attr_start_date::date AND att.attr_end_date::date
              OR gol.end_date BETWEEN att.attr_start_date::date AND att.attr_end_date::date
              OR (gol.start_date <= att.attr_start_date::date AND gol.end_date >= att.attr_end_date::date));
