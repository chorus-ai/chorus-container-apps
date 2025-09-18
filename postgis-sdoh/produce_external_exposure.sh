#!/bin/bash


IFS=',' read -r -a DATA_SOURCE_LIST <<< "$DATA_SOURCES"
IFS=',' read -r -a VARIABLE_LIST <<< "$VARIABLES"

echo "Loading LOCATION AND LOCATION_HISTORY tables..."

psql -v ON_ERROR_STOP=1 -U postgres -c "\copy working.location FROM '/source/LOCATION.csv' CSV HEADER DELIMITER E','"
psql -v ON_ERROR_STOP=1 -U postgres -c "\copy working.location_history FROM '/source/LOCATION_HISTORY.csv' CSV HEADER DELIMITER E','"
psql -v ON_ERROR_STOP=1 -U postgres -c "CREATE TABLE working.location_merge AS (SELECT b.*, a.latitude, a.longitude FROM working.location a INNER JOIN working.location_history b ON a.location_id = b.location_id);"
psql -v ON_ERROR_STOP=1 -U postgres -c "ALTER TABLE working.location_merge ADD COLUMN geom geometry(Point, 4326);"
psql -v ON_ERROR_STOP=1 -U postgres -c "UPDATE working.location_merge SET geom = ST_SetSRID(ST_POINT(longitude, latitude), 4326);"
echo "LOCATION and LOCATION_HISTORY loaded and merged! Launching ingestion of datasets (${DATA_SOURCES})..."

rm -rf /shapes
mkdir /shapes

for src in "${DATA_SOURCE_LIST[@]}"; do
  echo "*********************************************"
  echo "Retrieving metadata for variable ${src}..."
  # Pull metadata from database
  download_url=$(psql -U postgres -AXqtc "SELECT download_url FROM backbone.data_source WHERE data_source_uuid = ${src}")
  file_format=$(psql -U postgres -AXqtc "SELECT download_subtype FROM backbone.data_source WHERE data_source_uuid = ${src}")
  shape_name=$(psql -U postgres -AXqtc "SELECT download_filename FROM backbone.data_source WHERE data_source_uuid = ${src}")
  shape_no_ext=$(psql -U postgres -AXqtc "SELECT split_part(download_filename, '.', 1) FROM backbone.data_source WHERE data_source_uuid = ${src}")
  data_standard=$(psql -U postgres -AXqtc "SELECT download_data_standard FROM backbone.data_source WHERE data_source_uuid = ${src}")
  srid=$(psql -U postgres -AXqtc "SELECT srid FROM backbone.data_source WHERE data_source_uuid = ${src}")
  geom_type=$(psql -U postgres -AXqtc "SELECT COALESCE(geom_type, 'MISSING') FROM backbone.data_source WHERE data_source_uuid = ${src}")


  echo "Metadata fetched from database!"
  echo "*********************************************"
  echo "*********************************************"
  echo "Fetching source data - ${shape_name} - for variable ${src}..."

  # Fetch and extract source files
  if  [ "$file_format" = "zip" ]; then
    wget -O "/shapes/${shape_name}.${file_format}" "${download_url}"
    unzip -qq -d "/shapes" "/shapes/${shape_name}.${file_format}"
    rm "/shapes/${shape_name}.${file_format}"
  elif   [ "$file_format" = "tar.gz" ]; then
    wget -O "/shapes/${shape_name}.${file_format}" "${download_url}"
    tar -xzf "/shapes/${shape_name}.${file_format}" -C "/shapes"
    rm "/shapes/${shape_name}.${file_format}"
  else
    echo "Catalog processing for ${file_format} not yet supported!"
    continue
  fi




  echo "Source data fetched from ${download_url}"
  echo "*********************************************"
  echo "*********************************************"
  echo "Ingesting source data - ${shape_name} - for variable ${src}..."

  # Load source files into database
  if  [ "$geom_type" = "polygon" ]; then
    if  [ "$data_standard" = "shp" ]; then
        shp2pgsql \
          -d \
          -D \
          -I \
          -s "${srid}" \
          "/shapes/${shape_name}" \
          "${shape_no_ext}" \
          | psql -q -U postgres
      if  [ "$srid" != "4326" ]; then
        psql -v ON_ERROR_STOP=1 -U postgres -c "ALTER TABLE public.${shape_no_ext} ADD COLUMN wgs_geom geometry(MULTIPOLYGON, 4326);"
        psql -v ON_ERROR_STOP=1 -U postgres -c "UPDATE public.${shape_no_ext} SET wgs_geom = ST_TRANSFORM(geom, 4326);"
      else
        psql -v ON_ERROR_STOP=1 -U postgres -c "ALTER TABLE public.${shape_no_ext} ADD COLUMN wgs_geom geometry(MULTIPOLYGON, 4326);"
        psql -v ON_ERROR_STOP=1 -U postgres -c "UPDATE public.${shape_no_ext} SET wgs_geom = geom;"
      fi
    fi
  fi

  if  [ "$data_standard" = "gdb" ]; then
    ogr2ogr \
    -f "PostgreSQL" \
    -overwrite \
    PG:"host='0.0.0.0' port='5432' dbname='postgres' user='postgres' password='$PGPASSWORD'" \
    "/shapes/${shape_name}" \
    "${shape_no_ext}"
  fi


  echo "Source data ingested using shp2pgsql and ogr2ogr into  public.${shape_no_ext}!"

  echo "*********************************************"
done

for var in "${VARIABLE_LIST[@]}"; do
  echo "*********************************************"

  echo "Launching spatial join process to combine locations with variable ${var}..."


    geo_source=$(psql -U postgres -AXqtc "SELECT split_part(download_filename, '.', 1) FROM backbone.data_source WHERE data_source_uuid = (SELECT geom_dependency_uuid FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1)")
    var_source=$(psql -U postgres -AXqtc "SELECT split_part(download_filename, '.', 1) FROM backbone.data_source WHERE data_source_uuid = (SELECT data_source_uuid FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1)")
    geo_merge=$(psql -U postgres -AXqtc "SELECT geom_join_column FROM backbone.data_source WHERE data_source_uuid = (SELECT geom_dependency_uuid FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1)")
    var_merge=$(psql -U postgres -AXqtc "SELECT geom_join_column FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1")
    var_name=$(psql -U postgres -AXqtc "SELECT variable_name FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1")
    tmp_sql_file="/tmp/${var_name}.sql"

    if [ "$geo_source" != "$var_source" ]; then
      # geometry and variables are separate (e.g. SVI stats and county geographic info)
      sed "s/@VAR_NAME/$var_name/g" /sql/spatial_join_2pt.sql | \
          sed "s/@VAR_SRC/$var_source/g" | \
          sed "s/@GEO_SRC/$geo_source/g" | \
          sed "s/@VAR_MERGE/$var_merge/g" | \
          sed "s/@GEO_MERGE/$geo_merge/g" > "/tmp/${var_name}.sql"
    else
      sed "s/@VAR_NAME/$var_name/g" /sql/spatial_join_1pt.sql | \
          sed "s/@VAR_SRC/$var_source/g" > "/tmp/${var_name}.sql"
    fi

    psql -v ON_ERROR_STOP=1 -U postgres -f "${tmp_sql_file}"
done

echo "Data sets and variables processed! Exporting EXTERNAL_EXPOSURE..."

psql -v ON_ERROR_STOP=1 -U postgres -c "\copy working.external_exposure TO '/source/EXTERNAL_EXPOSURE.csv' CSV HEADER DELIMITER E','"
