from etl.common import CDM_TABLES

for table in CDM_TABLES:
    sqlPart = f"CREATE TABLE omopcdm.{table} AS SELECT * FROM omopcdm_20240522_20240530120000.{table};"
    with open('/tmp/copy-schema.sql', 'a') as f:
        f.write(sqlPart)
        f.write("\n")
