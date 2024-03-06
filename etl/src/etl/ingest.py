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
    rename_schema,
    subprocess_run,
    view_tables,
)

@prefect.flow(flow_run_name=generate_flow_run_name)
def ingest_etl(
        mode: typing.Literal['columbia', 'duke', 'emory', 'mgh',
                             'mit', 'mayo', 'nationwide', 'newmexico',
                             'ucla', 'ucsf', 'florida', 'pittsburgh',
                             'virginia', 'seattle'] = 'mit',
        run_qc: bool = True,
        load_args: dict[str, str] = {"path":"/data/",
                                     "delimeter":",",
                                     "header":"true"}):
    """ETL Pipeline for Ingesting Data."""
    logger = prefect.get_run_logger()
    logger.info("Started ETL pipeline for ingesting source data.")
    t0 = datetime.datetime.now()
    logger.info("Populating staging area...")
    os.environ['MODEPGDB'] = mode # set env variable based on mode selected at prefect deployment
    has_header = load_args["header"].lower() in ['true', '1', 't', 'y', 'yes']

    create_or_replace_schema(
        TEMP_SCHEMA,
        "Staging area for ingest ETL",
    )

    load_and_execute_sql(
        'cdm-ddl.sql',
        schema=TEMP_SCHEMA,
    )
    view_tables(
        VOCABULARY_SCHEMA,
        VOCABULARY_TABLES,
        schema=TEMP_SCHEMA,
    )

    logger.info(f"Building {mode}...")
    base_etl_dir = os.path.join(ETL_DIR, 'ingest-etl', mode)

    orchestrate_sql_w_dependencies(base_etl_dir, TEMP_SCHEMA)

    ingest_omop(DELIVERED_TABLES,
                TEMP_SCHEMA,
                load_args["path"],
                load_args["delimiter"],
                has_header
    )

    schemas = get_schemas_as_list()

    if PRODUCTION_SCHEMA in schemas:
        archive_suffix = get_last_cdm_release_date(PRODUCTION_SCHEMA)
        archive_and_rename_schema(TEMP_SCHEMA, PRODUCTION_SCHEMA, archive_suffix)
    else:
        rename_schema(TEMP_SCHEMA, PRODUCTION_SCHEMA)

    if run_qc:
        subprocess_run(
            ['Rscript', os.path.join(ETL_DIR, 'ares.R'), ARES_DATA_ROOT, mode, PRODUCTION_SCHEMA],
            cwd='/ares',
            check=True,
        )

    t1 = datetime.datetime.now()
    minutes = round((t1 - t0).total_seconds() / 60)
    logger.info(f"Successfully finished ETL pipeline for ingesting {mode} in {minutes} minutes.")
