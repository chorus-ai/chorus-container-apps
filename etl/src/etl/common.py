from itertools import chain
import contextlib
import datetime
from typing import List
import os
import subprocess
import urllib.request
import yaml

import azure.identity
import azure.storage.blob
import prefect
import psycopg
import pyarrow, pyarrow.csv
import sqlparse

from .config import (
    AZURE_STORAGE_ACCOUNT,
    AZURE_STORAGE_ACCOUNT_CONTAINER,
    ETL_DIR,
    INGEST_MODE,
    PGHOST,
    PGPORT,
    PGUSER,
    PGPASSWORD,
)

VOCABULARY_TABLES = [
    'concept',
    'vocabulary',
    'domain',
    'concept_class',
    'concept_relationship',
    'relationship',
    'concept_synonym',
    'concept_ancestor',
    'drug_strength',
    'concept_recommended'
]

CDM_TABLES = [
    'person',
    'observation_period',
    'visit_occurrence',
    'visit_detail',
    'condition_occurrence',
    'drug_exposure',
    'procedure_occurrence',
    'device_exposure',
    'measurement',
    'observation',
    'death',
    'note',
    'note_nlp',
    'specimen',
    'fact_relationship',
    'location',
    'care_site',
    'provider',
    'payer_plan_period',
    'cost',
    'drug_era',
    'dose_era',
    'condition_era',
    'episode',
    'episode_event',
    'metadata',
    'cdm_source',
    'concept',
    'vocabulary',
    'domain',
    'concept_class',
    'concept_relationship',
    'relationship',
    'concept_synonym',
    'concept_ancestor',
    'source_to_concept_map',
    'drug_strength',
    'cohort',
    'cohort_definition',
]

DELIVERED_TABLES = [
    'person',
    'observation_period',
    'visit_occurrence',
    'visit_detail',
    'condition_occurrence',
    'drug_exposure',
    'procedure_occurrence',
    'device_exposure',
    'measurement',
    'observation',
    'death',
    'note',
    'note_nlp',
    'specimen',
    'drug_era',
    'dose_era',
    'condition_era',
]

SITE_LIST = ['columbia',
             'duke',
             'emory',
             'mgh',
             'mit',
             'mayo',
             'nationwide',
             'newmexico',
             'ucla',
             'ucsf',
             'florida',
             'pittsburgh',
             'seattle',
             'virginia']

@contextlib.contextmanager
def postgresql_cursor():
    pgdbname = os.environ['MODEPGDB']
    with psycopg.connect(f'postgresql://{PGUSER}:{PGPASSWORD}@{PGHOST}:{PGPORT}/{pgdbname}') as conn:
        with conn.cursor() as c:
            yield c

def generate_flow_run_name():
    flow_run = prefect.runtime.flow_run
    flow_name = flow_run.flow_name
    start_time = datetime.datetime.now()
    return f"{flow_name}-{start_time:%m%d-%H%M}"

@prefect.task(task_run_name="{command[0]}")
def subprocess_run(command, input=None, cwd=None, env=None, check=True):
    logger = prefect.get_run_logger()
    logger.info(' '.join(command))
    if isinstance(input, str):
        input = input.encode('utf-8')
    return subprocess.run(command, input=input, cwd=cwd, env=env, check=check)


@prefect.task(task_run_name="{name}", tags=["query"])
def execute_sql(
        name: str,
        qs: str|list[str],
        args: dict|None = None,
        schema: str|None = None,
        cursor = None) -> None:
    """Execute a sequence of SQL queries."""
    logger = prefect.get_run_logger()
    if isinstance(qs, str):
        qs = sqlparse.split(qs)
    if schema is not None:
        qs = [f"SET search_path TO {schema};"] + qs
    if cursor is not None:
        for q in qs:
            logger.info(q)
            cursor.execute(q)
    else:
        with postgresql_cursor() as c:
            for q in qs:
                logger.info(q)
                c.execute(q)


def load_sql(filename: str) -> list[str]:
    """Load SQL queries from a file."""
    with open(os.path.join(ETL_DIR, filename)) as f:
        return sqlparse.split(f.read())

def load_and_execute_sql(
        filename: str,
        args: dict|None = None,
        schema: str|None = None,
        cursor = None) -> None:
    execute_sql(filename, load_sql(filename), args, schema, cursor)


def create_or_replace_schema(schema: str, comment: str) -> None:
    """Create a schema with the given name, replacing any existing schema."""
    execute_sql(
        f"SCHEMA {schema}",
        [
            f"DROP SCHEMA IF EXISTS {schema} CASCADE;",
            f"CREATE SCHEMA {schema};",
        ],
    )


def archive_and_rename_schema(src_schema: str, trg_schema: str, date_suffix: str) -> None:
    execute_sql(
        f"RENAME SCHEMA {src_schema} TO {trg_schema}",
        [
            f"ALTER SCHEMA {trg_schema} RENAME TO {trg_schema}_{date_suffix} CASCADE;",
            f"ALTER SCHEMA {src_schema} RENAME TO {trg_schema};",
        ]
    )


def rename_schema(src_schema: str, trg_schema: str) -> None:
    execute_sql(
        f"RENAME SCHEMA {src_schema} TO {trg_schema}",
        [
            f"ALTER SCHEMA {src_schema} RENAME TO {trg_schema};",
        ]
    )


def drop_schema(schema) -> None:
    execute_sql(
        f"DROP {schema}",
        [
            f"DROP SCHEMA {schema} CASCADE;",
        ]
    )


def get_schemas_as_list() -> List[str]:
    with postgresql_cursor() as c:
        c.execute("SELECT schema_name FROM information_schema.schemata;")
        return [row.schema_name for row in c.fetchall()]


def view_tables(
        source_schema: str,
        source_tables: list[str],
        schema: str,
        prefix: str = '',
        suffix: str = '') -> None:
    """Creates views of tables in a different schema."""
    names = []
    qs = []
    for table in source_tables:
        names.append(f"CREATE VIEW OF {table} IN {source_schema}")
        source_name = f"{qn(source_schema)}.{qn(table)}"
        target_name = f"{schema}.{prefix + table + suffix}"
        qs.append(
            f"CREATE VIEW {target_name} AS \n"
            f"SELECT * FROM  {source_name};"
        )
    futures = execute_sql.map(names, qs)
    for future in futures:
        future.result()


def pipe_table_transfer(
        source_dbname: str,
        source_schema: str,
        source_tables: list[str],
        trg_schema: str,
        trg_dbname: str,
        prefix: str = '',
        suffix: str = '') -> None:
    """Creates tables in a different database using the dblink extension."""
    names = []
    qs = []
    for table in source_tables:
        names.append(f"TRANSFER {table} IN {source_dbname} to {trg_dbname}")
        source_name = f"{source_schema}.{table}"
        target_name = f"{trg_schema}.{prefix + table + suffix}"
        subprocess_run(
            [
                f'PGPASSWORD={PGPASSWORD}',
                'psql',
                '-d', source_dbname,
                '-h', PGHOST,
                '-U', PGUSER,
                '-p', PGPORT,
                '-c', f"\copy {source_name} TO STDOUT CSV",
                '|',
                f'PGPASSWORD={PGPASSWORD}',
                'psql',
                '-d', trg_dbname,
                '-h', PGHOST,
                '-U', PGUSER,
                '-p', PGPORT,
                '-c', f"\copy {target_name} FROM STDIN CSV",
            ],
        check=True,
        )


def load_yaml(
        base_path_dev: str,
        file_name: str = 'orchestrate.yaml') -> dict:
    with open(os.path.join(base_path_dev, file_name), "r") as stream:
        orchestration = yaml.safe_load(stream)
    return orchestration


def extract_dep_layers(deps, script):
    dep_list = set(deps[script])
    rval = set()
    while dep_list:
        dep_script = dep_list.pop()
        if dep_script != script:
            rval.add(dep_script)
            to_add = set(deps.get(dep_script,[]))
            dep_list.update(to_add.difference(rval))
    return sorted(rval)


def process_yaml(
        orchestration: dict,
        base_path_dev: str) -> dict:
    dep_compact = {}
    dep_full = {}
    for transform in orchestration['transformations']['orchestrate']['sequence']:
        for idx, script in enumerate(transform['sql']):
            script_path = os.path.join(base_path_dev, transform['sub_path'], script)
            file_list = [
                script_path
            ]
            if transform['depends']:
                dep_list = [
                    os.path.join(base_path_dev, dep['sub_path'], script)
                    for dep in transform['depends'] for script in dep['sql']
                ]
            else:
                dep_list = []
            dep_compact[script_path] = dep_list
            if not transform['parallel'] and idx > 0:
                dep_compact[script_path].append(os.path.join(base_path_dev, transform['sub_path'], transform['sql'][idx - 1]))
    for script in dep_compact:
        dep_full[script] = extract_dep_layers(dep_compact, script)
    return dep_full


def create_yaml_para_groupings(
        deps: dict) -> list:

    groups = []
    completed = []
    while len(completed) < len(deps):
        next_group = [
            file
            for file in deps.keys()
            if file not in completed and all(dep in completed for dep in deps[file])]
        assert next_group
        groups.append(next_group)
        completed.extend(next_group)
    return groups

def orchestrate_sql_w_dependencies(
        base_etl_dir: str,
        stage_schema: str
) -> None:
    # Function executes multiple sql scripts concurrently
    my_orchest = load_yaml(
        base_etl_dir,
        'orchestrate.yaml'
    )
    dependencies = process_yaml(
        my_orchest,
        base_etl_dir
    )
    grouped_filenames = create_yaml_para_groupings(
        dependencies
    )
    for filenames in grouped_filenames:
        futures = [
            execute_sql.submit(
                filename,
                load_sql(filename),
                schema=stage_schema
            )
            for filename in filenames
        ]
        for future in futures:
            future.result()


def get_last_cdm_release_date(schema: str) -> str:
    with postgresql_cursor() as c:
        get_rd_sql = f"SELECT TO_CHAR(cdm_release_date, 'YYYYMMDD') AS release_date_str FROM {schema}.cdm_source;"
        c.execute(get_rd_sql)
        release_date_str = c.fetchone()

    return release_date_str[0]



def copy_db_data_from_stdin(
        schema: str,
        table: str,
        copy_path: str,
        delim: str,
        header = True,
) -> None:
    hd = '2' if header else '1'
    pgdbname = os.environ['MODEPGDB']
    subprocess_run(
        [
            'tail',
            '-q', # remove file references
            '-n', f'+{hd}', # remove headers if necessary
            copy_path,
            '|',
            f'PGPASSWORD={PGPASSWORD}',
            'psql',
            '-d', pgdbname,
            '-h', PGHOST,
            '-U', PGUSER,
            '-p', PGPORT,
            '-c', f"\copy {schema}.{table} FROM STDIN CSV DELIMITER E'{delim}'",
        ],
        check=True,
    )

def ingest_omop(
        tables: list[str],
        schema: str,
        copy_path: str,
        delim: str,
        header = True,
) -> None:
    logger = prefect.get_run_logger()
    for table in tables:
        try:
            copy_db_data_from_stdin(schema, table, copy_path, delim, header)
            logger.info(f'Copied {table} from {copy_path} to database')
        except Exception as e:
            logger.info(f'Unable to copy {table} from {copy_path} to database: {e}')
            continue



