import datetime
import itertools
import os
import typing

import prefect

from .config import (
    ETL_DIR,
    ARES_DATA_ROOT,
    PRODUCTION_SCHEMA,
    TEMP_SCHEMA,
    VOCABULARY_SCHEMA,
)

from .common import (
    CDM_TABLES,
    DELIVERED_TABLES,
    SITE_LIST,
    VOCABULARY_TABLES,
    archive_and_rename_schema,
    create_or_replace_schema,
    execute_sql,
    generate_flow_run_name,
    get_last_cdm_release_date,
    get_schemas_as_list,
    ingest_omop,
    load_and_execute_sql,
    load_sql,
    orchestrate_sql_w_dependencies,
    pipe_table_transfer,
    rename_schema,
    subprocess_run,
    view_tables
)
@prefect.flow(flow_run_name=generate_flow_run_name)
def merge_etl(run_qc: bool = True):
    logger = prefect.get_run_logger()
    logger.info("Started ETL pipeline for merging source data.")
    t0 = datetime.datetime.now()
    os.environ['MODEPGDB'] = 'merge'  # set env variable based on merge
    create_or_replace_schema(
        TEMP_SCHEMA,
        "Staging area for merge ETL",
    )

    view_tables(
        VOCABULARY_SCHEMA,
        VOCABULARY_TABLES,
        schema=TEMP_SCHEMA,
    )
    for site in SITE_LIST:
        logger.info(f"Populating temporary schema for {site}...")
        site_schema = site
        create_or_replace_schema(
            site_schema,
            f"Temporary data for {site}",
        )
        load_and_execute_sql(
            'cdm-ddl.sql',
            schema=site_schema,
        )
        pipe_table_transfer(
            site,
            PRODUCTION_SCHEMA,
            DELIVERED_TABLES,
            site_schema,
            'merge'
        )
        logger.info(f"Temporary schema for {site} populated successfully!")

    logger.info(f"Building {mode}...")
    base_etl_dir = os.path.join(ETL_DIR, 'merge-etl', mode)

    orchestrate_sql_w_dependencies(base_etl_dir, TEMP_SCHEMA)

    schemas = get_schemas_as_list()

    if PRODUCTION_SCHEMA in schemas:
        archive_suffix = get_last_cdm_release_date(PRODUCTION_SCHEMA)
        archive_and_rename_schema(TEMP_SCHEMA, PRODUCTION_SCHEMA, archive_suffix)
    else:
        rename_schema(TEMP_SCHEMA, PRODUCTION_SCHEMA)

    if run_qc:
        subprocess_run(
            [os.path.join(ETL_DIR, 'ares.R'), ARES_DATA_ROOT, 'merge', PRODUCTION_SCHEMA],
            cwd='/ares',
            check=True,
        )

    t1 = datetime.datetime.now()
    minutes = round((t1 - t0).total_seconds() / 60)
    logger.info(f"Successfully finished ETL pipeline for merging CHoRUS sources in {minutes} minutes.")

