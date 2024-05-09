import urllib
import os
import json
import pandas as pd
from urllib import request, parse

CHORUS_WEBAPI_BACKEND = os.environ['CHORUS_WEBAPI_BACKEND']
COHORT_DIR = '/tmp/cohorts/PhenotypeLibrary/inst/cohorts'
COHORT_LIST_DIR = "/tmp/cohorts/PhenotypeLibrary/inst"
cohort_list = pd.read_csv(os.path.join(COHORT_LIST_DIR, "Cohorts.csv"))


name = cohort_list[cohort_list["cohortId"] == 1313]

cidbuffer = 10000
for cohortname in os.listdir(COHORT_DIR):
    pid = cohortname.split('.')[0]
    name = cohort_list[cohort_list["cohortId"] == int(pid)]["cohortName"].item()
    desc = cohort_list[cohort_list["cohortId"] == int(pid)]["cohortNameLong"].item()
    with open(os.path.join(COHORT_DIR,cohortname), 'r') as f:
        try:
            content = json.load(f)
            cohortdef = {
                 "id": cidbuffer,
                 "name": "[PheLib - " + str(pid) + "] " + name,
                 "description": desc,
                 "hasWriteAccess": False,
                  "tags": [],
                "expressionType": "EXTERNAL_SOURCED",
                "expression": {}
            }
            cohortdef["expression"] = content
            outname = "query_" + cohortname
            with open("/tmp/cohorts/queries/" + outname, 'w') as o:
                o.write(json.dumps(cohortdef))
            # print(cohortname + ": " + content['CensoringCriteria'] )
        except Exception as e:
            print(e)
            continue

        cidbuffer += 1