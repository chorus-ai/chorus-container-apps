import os
import re

PGHOST = os.environ['PGHOST']
PGPORT = int(os.environ.get('PGPORT', '5432'))
PGUSER = os.environ.get('PGUSER')
PGPASSWORD = os.environ.get('PGPASSWORD')

ARES_DATA_ROOT = '/ares/data'
PRODUCTION_SCHEMA = 'omopcdm'
TEMP_SCHEMA = 'tmp'
VOCABULARY_SCHEMA = 'vocabulary'


ETL_DIR = os.path.dirname(__file__)
