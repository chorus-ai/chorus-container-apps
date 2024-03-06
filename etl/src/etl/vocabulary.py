import os

import prefect
import typing

from .common import (
    VOCABULARY_TABLES,
    copy_db_data_from_stdin,
    create_or_replace_schema,
    generate_flow_run_name,
    load_and_execute_sql,
)

from .config import (
    VOCABULARY_SCHEMA
)

@prefect.flow(flow_run_name=generate_flow_run_name)
def upload_vocabulary(db: typing.Literal['columbia', 'duke', 'emory', 'mgh',
                             'mit', 'mayo', 'nationwide', 'newmexico',
                             'ucla', 'ucsf', 'florida', 'pittsburgh',
                             'virginia', 'seattle', 'merge'] = 'mit',
                      load_args: dict[str, str] = {"path": "/data/",
                                                   "delimeter": ",",
                                                   "header": "true"}
                      ):
    """Load vocabulary files from mounted directory to a Postgres schema."""
    logger = prefect.get_run_logger()
    logger.info("Started Vocabulary Reload Process.")
    t0 = datetime.datetime.now()
    os.environ['MODEPGDB'] = db  # set env variable based on mode selected
    has_header = load_args["header"].lower() in ['true', '1', 't', 'y', 'yes']

    create_or_replace_schema(VOCABULARY_SCHEMA, "OMOP Vocabularies")
    load_and_execute_sql(
        'vocabulary-ddl.sql',
        schema=VOCABULARY_SCHEMA
    )

    for table in VOCABULARY_TABLES:
        copy_db_data_from_stdin(
            VOCABULARY_SCHEMA,
            table,
            os.path.join(load_args['path'], f'{table}.csv'),
            load_args['delimiter'],
            has_header
        )
    try:
        load_and_execute_sql(
            'vocabulary-index.sql',
            schema=VOCABULARY_SCHEMA
        )
    except Exception as e:
        logger.info(f"Could not index vocabulary due to: {e}")

    t1 = datetime.datetime.now()
    minutes = round((t1 - t0).total_seconds() / 60)
    logger.info(f"Successfully finished Vocabulary Reload for {db} in {minutes} minutes.")


