from python:3.12-bookworm

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        cargo

RUN pip install azure-identity \
                azure-mgmt-resource \
                msgraph-sdk \
                pandas \
                dash \
                dash_bootstrap_components \
                dash_ag_grid

COPY app.py /app/app.py
COPY assets /app/assets
COPY read_access_chorus.py /app/read_access_chorus.py
COPY test.csv /az_user/data/test.csv

ENTRYPOINT ["python3", "/app/app.py"]

