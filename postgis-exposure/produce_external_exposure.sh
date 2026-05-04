#!/bin/bash

# Function to check command status
check_status() {
  if [ $? -ne 0 ]; then
    echo "ERROR: $1 failed."
    exit 1
  fi
}

CSV_HEADER_COLS=()

array_contains() {
  local needle="$1"
  shift
  local item
  for item in "$@"; do
    if [ "$item" = "$needle" ]; then
      return 0
    fi
  done
  return 1
}

get_csv_header_columns() {
  local csv_path="$1"
  if [ ! -s "$csv_path" ]; then
    echo "ERROR: Required file ${csv_path} is missing or empty."
    exit 1
  fi

  local raw_header
  raw_header=$(head -n 1 "$csv_path" | tr -d '\r')
  if [ -z "$raw_header" ]; then
    echo "ERROR: ${csv_path} does not contain a valid header row."
    exit 1
  fi

  local raw_cols=()
  IFS=',' read -r -a raw_cols <<< "$raw_header"

  CSV_HEADER_COLS=()
  local raw_col
  for raw_col in "${raw_cols[@]}"; do
    local normalized
    normalized=$(echo "$raw_col" \
      | tr '[:upper:]' '[:lower:]' \
      | sed 's/^"//; s/"$//; s/^[[:space:]]*//; s/[[:space:]]*$//')
    if [ -n "$normalized" ]; then
      CSV_HEADER_COLS+=("$normalized")
    fi
  done
}

validate_supported_columns() {
  local file_name="$1"
  shift
  local supported_cols=("$@")
  local unsupported=()
  local col

  for col in "${CSV_HEADER_COLS[@]}"; do
    if ! array_contains "$col" "${supported_cols[@]}"; then
      unsupported+=("$col")
    fi
  done

  if [ "${#unsupported[@]}" -gt 0 ]; then
    echo "ERROR: ${file_name} contains unsupported columns: ${unsupported[*]}"
    exit 1
  fi
}

validate_required_columns() {
  local file_name="$1"
  shift
  local required_cols=("$@")
  local missing=()
  local col

  for col in "${required_cols[@]}"; do
    if ! array_contains "$col" "${CSV_HEADER_COLS[@]}"; then
      missing+=("$col")
    fi
  done

  if [ "${#missing[@]}" -gt 0 ]; then
    echo "ERROR: ${file_name} is missing required columns: ${missing[*]}"
    exit 1
  fi
}

csv_header_sql_list() {
  local IFS=','
  echo "${CSV_HEADER_COLS[*]}"
}

IFS=',' read -r -a DATA_SOURCE_LIST <<< "$DATA_SOURCES"
IFS=',' read -r -a VARIABLE_LIST <<< "$VARIABLES"
GEO_SUBSET_SOURCES=()

# 1. Wait for Postgres to be ready
echo "Waiting for PostgreSQL to start..."
until psql -U postgres -c '\l'; do
  echo "Postgres is unavailable - sleeping"
  sleep 2
done
echo "Postgres is up!"

# 2. Wait for Init Script (Schema Creation)
echo "Waiting for 'working' schema..."
until psql -U postgres -c "SELECT 1 FROM information_schema.schemata WHERE schema_name = 'working'" | grep -q 1; do
  echo "Schema 'working' not ready - sleeping"
  sleep 2
done
echo "Schema 'working' found!"

echo "Loading LOCATION AND LOCATION_HISTORY tables..."

LOCATION_SUPPORTED_COLS=(
  location_id
  address_1
  address_2
  city
  state
  zip
  county
  location_source_value
  country_concept_id
  country_source_value
  latitude
  longitude
  modifier_source_value
)
LOCATION_REQUIRED_COLS=(location_id latitude longitude)

LOCATION_HISTORY_SUPPORTED_COLS=(
  location_id
  relationship_type_concept_id
  domain_id
  entity_id
  start_date
  end_date
)
LOCATION_HISTORY_REQUIRED_COLS=(location_id start_date end_date)

get_csv_header_columns "/source/LOCATION.csv"
validate_supported_columns "LOCATION.csv" "${LOCATION_SUPPORTED_COLS[@]}"
validate_required_columns "LOCATION.csv" "${LOCATION_REQUIRED_COLS[@]}"
LOCATION_COPY_COLS=$(csv_header_sql_list)

psql -v ON_ERROR_STOP=1 -U postgres -c "TRUNCATE TABLE working.location;"
psql -v ON_ERROR_STOP=1 -U postgres -c "DROP TABLE IF EXISTS working.location_raw;"
psql -v ON_ERROR_STOP=1 -U postgres -c "
  CREATE TABLE working.location_raw (
    location_id text,
    address_1 text,
    address_2 text,
    city text,
    state text,
    zip text,
    county text,
    location_source_value text,
    country_concept_id text,
    country_source_value text,
    latitude text,
    longitude text,
    modifier_source_value text
  );"

psql -v ON_ERROR_STOP=1 -U postgres -c "\copy working.location_raw(${LOCATION_COPY_COLS}) FROM '/source/LOCATION.csv' CSV HEADER DELIMITER E','"
check_status "Loading LOCATION.csv"

RAW_LOC_COUNT=$(psql -U postgres -t -c "SELECT count(*) FROM working.location_raw" | xargs)

psql -v ON_ERROR_STOP=1 -U postgres -c "TRUNCATE TABLE working.location;"
psql -v ON_ERROR_STOP=1 -U postgres -c "
INSERT INTO working.location (
  location_id,
  address_1,
  address_2,
  city,
  state,
  zip,
  county,
  location_source_value,
  country_concept_id,
  country_source_value,
  latitude,
  longitude,
  modifier_source_value
)
SELECT
  location_id,
  NULLIF(address_1, ''),
  NULLIF(address_2, ''),
  NULLIF(city, ''),
  NULLIF(state, ''),
  CASE
    WHEN NULLIF(zip, '') IS NULL THEN NULL
    ELSE LEFT(regexp_replace(zip, '[^0-9-]', '', 'g'), 10)
  END,
  NULLIF(county, ''),
  NULLIF(location_source_value, ''),
  country_concept_id,
  NULLIF(country_source_value, ''),
  latitude,
  longitude,
  NULLIF(modifier_source_value, '')
FROM (
  SELECT
    CASE
      WHEN NULLIF(location_id, '') ~ '^[0-9]+$' THEN NULLIF(location_id, '')::integer
      ELSE NULL
    END AS location_id,
    address_1,
    address_2,
    city,
    state,
    zip,
    county,
    location_source_value,
    CASE
      WHEN NULLIF(country_concept_id, '') ~ '^[-]?[0-9]+$' THEN NULLIF(country_concept_id, '')::integer
      ELSE NULL
    END AS country_concept_id,
    country_source_value,
    CASE
      WHEN NULLIF(latitude, '') ~ '^[-+]?[0-9]+([.][0-9]+)?$' THEN NULLIF(latitude, '')::numeric
      ELSE NULL
    END AS latitude,
    CASE
      WHEN NULLIF(longitude, '') ~ '^[-+]?[0-9]+([.][0-9]+)?$' THEN NULLIF(longitude, '')::numeric
      ELSE NULL
    END AS longitude,
    modifier_source_value
  FROM working.location_raw
) cleaned
WHERE location_id IS NOT NULL
  AND latitude IS NOT NULL
  AND longitude IS NOT NULL
  AND latitude BETWEEN -90 AND 90
  AND longitude BETWEEN -180 AND 180;"
check_status "Normalizing LOCATION.csv"

LOC_COUNT=$(psql -U postgres -t -c "SELECT count(*) FROM working.location" | xargs)
LOC_SKIPPED=$((RAW_LOC_COUNT - LOC_COUNT))
echo "Loaded ${LOC_COUNT} valid LOCATION rows; skipped ${LOC_SKIPPED} rows missing required linkage fields or with invalid coordinates."

get_csv_header_columns "/source/LOCATION_HISTORY.csv"
validate_supported_columns "LOCATION_HISTORY.csv" "${LOCATION_HISTORY_SUPPORTED_COLS[@]}"
validate_required_columns "LOCATION_HISTORY.csv" "${LOCATION_HISTORY_REQUIRED_COLS[@]}"
LOCATION_HISTORY_COPY_COLS=$(csv_header_sql_list)

psql -v ON_ERROR_STOP=1 -U postgres -c "TRUNCATE TABLE working.location_history;"
psql -v ON_ERROR_STOP=1 -U postgres -c "DROP TABLE IF EXISTS working.location_history_raw;"
psql -v ON_ERROR_STOP=1 -U postgres -c "
  CREATE TABLE working.location_history_raw (
    location_id text,
    relationship_type_concept_id text,
    domain_id text,
    entity_id text,
    start_date text,
    end_date text
  );"

psql -v ON_ERROR_STOP=1 -U postgres -c "\copy working.location_history_raw(${LOCATION_HISTORY_COPY_COLS}) FROM '/source/LOCATION_HISTORY.csv' CSV HEADER DELIMITER E','"
check_status "Loading LOCATION_HISTORY.csv"

RAW_LOC_HIST_COUNT=$(psql -U postgres -t -c "SELECT count(*) FROM working.location_history_raw" | xargs)

psql -v ON_ERROR_STOP=1 -U postgres -c "
INSERT INTO working.location_history (
  location_id,
  relationship_type_concept_id,
  domain_id,
  entity_id,
  start_date,
  end_date
)
SELECT
  location_id,
  relationship_type_concept_id,
  domain_id,
  entity_id,
  start_date,
  end_date
FROM (
  SELECT
    CASE
      WHEN NULLIF(location_id, '') ~ '^[0-9]+$' THEN NULLIF(location_id, '')::integer
      ELSE NULL
    END AS location_id,
    CASE
      WHEN NULLIF(relationship_type_concept_id, '') ~ '^[-]?[0-9]+$' THEN NULLIF(relationship_type_concept_id, '')::integer
      ELSE NULL
    END AS relationship_type_concept_id,
    CASE
      WHEN NULLIF(domain_id, '') ~ '^[-]?[0-9]+$' THEN NULLIF(domain_id, '')::integer
      ELSE NULL
    END AS domain_id,
    CASE
      WHEN NULLIF(entity_id, '') ~ '^[-]?[0-9]+$' THEN NULLIF(entity_id, '')::integer
      ELSE NULL
    END AS entity_id,
    CASE
      WHEN NULLIF(start_date, '') ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN NULLIF(start_date, '')::date
      WHEN NULLIF(start_date, '') ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' THEN to_date(NULLIF(start_date, ''), 'MM/DD/YYYY')
      ELSE NULL
    END AS start_date,
    CASE
      WHEN NULLIF(end_date, '') ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN NULLIF(end_date, '')::date
      WHEN NULLIF(end_date, '') ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' THEN to_date(NULLIF(end_date, ''), 'MM/DD/YYYY')
      ELSE NULL
    END AS end_date
  FROM working.location_history_raw
) cleaned
WHERE location_id IS NOT NULL
  AND start_date IS NOT NULL
  AND end_date IS NOT NULL
  AND end_date >= start_date;"
check_status "Normalizing LOCATION_HISTORY.csv"

LOC_HIST_COUNT=$(psql -U postgres -t -c "SELECT count(*) FROM working.location_history" | xargs)
LOC_HIST_SKIPPED=$((RAW_LOC_HIST_COUNT - LOC_HIST_COUNT))
echo "Loaded ${LOC_HIST_COUNT} valid LOCATION_HISTORY rows; skipped ${LOC_HIST_SKIPPED} rows missing required timing fields."

# Verify load
if [ "$LOC_COUNT" -eq "0" ]; then
   echo "ERROR: working.location has 0 rows after copy! Check input file '/source/LOCATION.csv'."
   ls -l /source/LOCATION.csv
   head /source/LOCATION.csv
   exit 1
fi
echo "Loaded $LOC_COUNT locations."

if [ "$LOC_HIST_COUNT" -eq "0" ]; then
   echo "ERROR: working.location_history has 0 rows after normalization! Check input file '/source/LOCATION_HISTORY.csv'."
   ls -l /source/LOCATION_HISTORY.csv
   head /source/LOCATION_HISTORY.csv
   exit 1
fi
echo "Loaded $LOC_HIST_COUNT location history rows."

psql -v ON_ERROR_STOP=1 -U postgres -c "DROP TABLE IF EXISTS working.location_merge;"
psql -v ON_ERROR_STOP=1 -U postgres -c "CREATE TABLE working.location_merge AS (SELECT b.*, a.latitude, a.longitude, a.modifier_source_value FROM working.location a INNER JOIN working.location_history b ON a.location_id = b.location_id);"
check_status "Merging location tables"

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
    wget -q -O "/shapes/${shape_name}.${file_format}" "${download_url}"
    if [ $? -ne 0 ] || [ ! -s "/shapes/${shape_name}.${file_format}" ]; then
        echo "ERROR: Download failed for ${shape_name} from ${download_url}. Skipping."
        rm -f "/shapes/${shape_name}.${file_format}"
        continue
    fi
    echo "Processing /shapes/${shape_name}.${file_format}..."
    unzip -qq -o -d "/shapes" "/shapes/${shape_name}.${file_format}"
    if [ $? -ne 0 ]; then
        echo "ERROR: Unzip failed for ${shape_name}! Skipping this data source."
        continue
    fi
    # Only remove if success
    rm "/shapes/${shape_name}.${file_format}"
  elif   [ "$file_format" = "tar.gz" ]; then
    wget -q -O "/shapes/${shape_name}.${file_format}" "${download_url}"
    if [ $? -ne 0 ] || [ ! -s "/shapes/${shape_name}.${file_format}" ]; then
        echo "ERROR: Download failed for ${shape_name} from ${download_url}. Skipping."
        rm -f "/shapes/${shape_name}.${file_format}"
        continue
    fi
    tar -xzf "/shapes/${shape_name}.${file_format}" -C "/shapes"
    rm "/shapes/${shape_name}.${file_format}"
  elif [ "$file_format" = "csv" ]; then
    wget -q -O "/shapes/${shape_name}" "${download_url}"
    if [ $? -ne 0 ] || [ ! -s "/shapes/${shape_name}" ]; then
        echo "ERROR: Download failed for ${shape_name} from ${download_url}. Skipping."
        rm -f "/shapes/${shape_name}"
        continue
    fi
  else
    echo "Catalog processing for ${file_format} not yet supported!"
    continue
  fi

  # echo "Source data extracted. Listing /shapes content:"
  # ls -R /shapes

  echo "Ingesting source data - ${shape_name} - for variable ${src}..."

  # Find actual file location (handle subfolders)
  # If shape_name is a directory (gdb), look for it. If file (shp), look for it.
  TARGET_PATH="/shapes/${shape_name}"
  
  if [ ! -e "$TARGET_PATH" ]; then
     echo "Target path $TARGET_PATH not found. Searching recursively..."
     FOUND=$(find /shapes -name "${shape_name}" -print -quit)
     if [ -n "$FOUND" ]; then
         echo "Found at $FOUND"
         TARGET_PATH="$FOUND"
     else
         echo "ERROR: Could not find ${shape_name} in /shapes"
         echo "Listing /shapes contents:"
         ls -R /shapes
     fi
  fi

  # Load source files into database
  if  [ "$geom_type" = "polygon" ]; then
    if  [ "$data_standard" = "shp" ]; then
        psql -q -v ON_ERROR_STOP=1 -U postgres -c "DROP TABLE IF EXISTS public.${shape_no_ext} CASCADE;" > /dev/null 2>&1
        shp2pgsql \
          -c \
          -D \
          -I \
          -s "${srid}" \
          "$TARGET_PATH" \
          "${shape_no_ext}" \
          | psql -q -v ON_ERROR_STOP=1 -U postgres > /dev/null 2>&1
      if  [ "$srid" != "4326" ]; then
        psql -q -v ON_ERROR_STOP=1 -U postgres -c "ALTER TABLE public.${shape_no_ext} ADD COLUMN wgs_geom geometry(MULTIPOLYGON, 4326);" > /dev/null
        psql -q -v ON_ERROR_STOP=1 -U postgres -c "UPDATE public.${shape_no_ext} SET wgs_geom = ST_TRANSFORM(geom, 4326);" > /dev/null
      else
        psql -q -v ON_ERROR_STOP=1 -U postgres -c "ALTER TABLE public.${shape_no_ext} ADD COLUMN wgs_geom geometry(MULTIPOLYGON, 4326);" > /dev/null
        psql -q -v ON_ERROR_STOP=1 -U postgres -c "UPDATE public.${shape_no_ext} SET wgs_geom = geom;" > /dev/null
      fi
    fi
  fi

  if  [ "$data_standard" = "gdb" ]; then
    # echo "Running ogr2ogr for GDB..."
    # Ensure we use WGS84 (EPSG:4326) and name the geometry column 'wgs_geom' for consistency with shapefile logic
    ogr2ogr \
    -f "PostgreSQL" \
    -overwrite \
    -t_srs EPSG:4326 \
    -lco GEOMETRY_NAME=wgs_geom \
    -nln "${shape_no_ext}" \
    PG:"host='localhost' port='5432' dbname='postgres' user='postgres' password='$PGPASSWORD'" \
    "$TARGET_PATH" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
       # echo "ogr2ogr success."
       :
    else
       echo "ogr2ogr FAILED for ${shape_no_ext}"
    fi
  fi

    if [ "$data_standard" = "csv" ]; then
     ogr2ogr \
     -f "PostgreSQL" \
     -overwrite \
     -oo HEADERS=YES \
    -oo AUTODETECT_TYPE=NO \
     -nln "${shape_no_ext}" \
     PG:"host='localhost' port='5432' dbname='postgres' user='postgres' password='$PGPASSWORD'" \
     "$TARGET_PATH" > /dev/null 2>&1

     if [ $? -eq 0 ]; then
       :
     else
       echo "ogr2ogr FAILED for ${shape_no_ext}"
     fi
    fi

  echo "Source data ingested for public.${shape_no_ext}!"

  echo "*********************************************"
done

# Handle VARIABLES=ALL — expand to all variable IDs for loaded data sources
if [ "${#VARIABLE_LIST[@]}" -eq 1 ] && [ "${VARIABLE_LIST[0]}" = "ALL" ]; then
  echo "VARIABLES=ALL detected. Fetching variable IDs for loaded data sources..."
  ALL_VARS=$(psql -U postgres -AXqtc "SELECT variable_source_id FROM backbone.variable_source WHERE data_source_uuid IN (${DATA_SOURCES}) ORDER BY variable_source_id")
  VARIABLE_LIST=()
  while IFS= read -r line; do
    [ -n "$line" ] && VARIABLE_LIST+=("$line")
  done <<< "$ALL_VARS"
  echo "Found ${#VARIABLE_LIST[@]} variables to process."
fi

for var in "${VARIABLE_LIST[@]}"; do
  echo "Launching spatial join process to combine locations with variable ${var}..."

    # Use a simpler query that doesn't rely on subselect limits which might be weird in some contexts
    # Also added debug echo
    
    geo_source=$(psql -U postgres -AXqtc "SELECT split_part(download_filename, '.', 1) FROM backbone.data_source WHERE data_source_uuid = (SELECT geom_dependency_uuid FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1)")
    var_source=$(psql -U postgres -AXqtc "SELECT split_part(download_filename, '.', 1) FROM backbone.data_source WHERE data_source_uuid = (SELECT data_source_uuid FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1)")
    geo_merge=$(psql -U postgres -AXqtc "SELECT geom_join_column FROM backbone.data_source WHERE data_source_uuid = (SELECT geom_dependency_uuid FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1)")
    var_merge=$(psql -U postgres -AXqtc "SELECT geom_join_column FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1")
    var_name=$(psql -U postgres -AXqtc "SELECT variable_name FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1")
    var_col=$(psql -U postgres -AXqtc "SELECT value_as_number_col FROM backbone.variable_source WHERE variable_source_id = ${var} LIMIT 1")
    # If var_col is empty, fallback to var_name (backward compatibility)
    if [ -z "$var_col" ]; then
        var_col="$var_name"
    fi

    # Guardrail: if metadata join key does not exist on the variable source table,
    # try common alternatives to avoid failing a full variable batch.
    has_var_merge_col=$(psql -U postgres -AXqtc "
      SELECT 1
      FROM information_schema.columns
      WHERE table_schema = 'public'
        AND table_name = lower('${var_source}')
        AND lower(column_name) = lower('${var_merge}')
      LIMIT 1")
    if [ -z "$has_var_merge_col" ]; then
      if psql -U postgres -AXqtc "SELECT 1 FROM information_schema.columns WHERE table_schema='public' AND table_name=lower('${var_source}') AND lower(column_name)='fips' LIMIT 1" | grep -q 1; then
        echo "Join key ${var_merge} not found on public.${var_source}; falling back to FIPS for variable ${var}."
        var_merge="FIPS"
      elif psql -U postgres -AXqtc "SELECT 1 FROM information_schema.columns WHERE table_schema='public' AND table_name=lower('${var_source}') AND lower(column_name)='geoid' LIMIT 1" | grep -q 1; then
        echo "Join key ${var_merge} not found on public.${var_source}; falling back to GEOID for variable ${var}."
        var_merge="GEOID"
      fi
    fi

    # Performance optimization: materialize a location-specific subset of the geometry source
    # once per run, then reuse it for all variables sharing that geometry source.
    if [ "$geo_source" != "$var_source" ]; then
      original_geo_source="$geo_source"
      subset_table="${original_geo_source}_loc_subset"

      if ! array_contains "$original_geo_source" "${GEO_SUBSET_SOURCES[@]}"; then
        echo "Building location-specific geometry subset for public.${original_geo_source}..."
        psql -q -v ON_ERROR_STOP=1 -U postgres -c "
          DROP TABLE IF EXISTS public.${subset_table};
          CREATE TABLE public.${subset_table} AS
          SELECT DISTINCT b.*
          FROM public.${original_geo_source} b
          INNER JOIN working.location_merge gol
            ON public.st_within(gol.geom, b.wgs_geom);
          CREATE INDEX IF NOT EXISTS ${subset_table}_wgs_geom_idx
            ON public.${subset_table}
            USING GIST (wgs_geom);
          ANALYZE public.${subset_table};
        " > /dev/null
        check_status "Building geometry subset for ${original_geo_source}"

        subset_count=$(psql -U postgres -AXqtc "SELECT count(*) FROM public.${subset_table}")
        echo "Subset public.${subset_table} contains ${subset_count} geometry rows."

        GEO_SUBSET_SOURCES+=("$original_geo_source")
      fi

      geo_source="$subset_table"
    fi
    
    tmp_sql_file="/tmp/${var_name}.sql"

    if [ "$geo_source" != "$var_source" ]; then
      sed "s/@VAR_NAME/$var_name/g" /sql/spatial_join_2pt.sql | \
          sed "s/@VAR_ID/$var/g" | \
          sed "s/@VAR_COL/$var_col/g" | \
          sed "s/@VAR_SRC/$var_source/g" | \
          sed "s/@GEO_SRC/$geo_source/g" | \
          sed "s/@VAR_MERGE/$var_merge/g" | \
          sed "s/@GEO_MERGE/$geo_merge/g" > "/tmp/${var_name}.sql"
    else
      sed "s/@VAR_NAME/$var_name/g" /sql/spatial_join_1pt.sql | \
          sed "s/@VAR_ID/$var/g" | \
          sed "s/@VAR_COL/$var_col/g" | \
          sed "s/@VAR_SRC/$var_source/g" > "/tmp/${var_name}.sql"
    fi

    psql -q -v ON_ERROR_STOP=1 -U postgres -f "${tmp_sql_file}" > /dev/null
done

echo "Data sets and variables processed! Exporting EXTERNAL_EXPOSURE..."

psql -q -v ON_ERROR_STOP=1 -U postgres -c "\copy working.external_exposure TO '/source/EXTERNAL_EXPOSURE.csv' CSV HEADER DELIMITER E','"
chmod 777 /source/EXTERNAL_EXPOSURE.csv
echo "Export complete."
