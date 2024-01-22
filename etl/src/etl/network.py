import datetime
import itertools
import os
import typing

import prefect

from .config import (
    ETL_DIR,
    ARES_DATA_ROOT
)
from .common import (
    generate_flow_run_name,
    subprocess_run
)

@prefect.flow(flow_run_name=generate_flow_run_name)
def index_network():
    """Quick Method for Building Network Ares Index."""
    logger = prefect.get_run_logger()
    logger.info("Started Ares Network Index Rebuild Process.")
    t0 = datetime.datetime.now()

    subprocess_run(
        [os.path.join(ETL_DIR, 'aresIndexer.R'), ARES_DATA_ROOT],
        cwd='/ares',
        check=True,
    )

    t1 = datetime.datetime.now()
    minutes = round((t1 - t0).total_seconds() / 60)
    logger.info(f"Successfully finished Ares Network Index Build in {minutes} minutes.")

