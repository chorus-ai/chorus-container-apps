FROM python:3.13-bookworm

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        postgresql-client
    
RUN pip install azure-storage-blob \
                azure-identity \
                pandas \
                dash \
                dash_bootstrap_components \
                dash_ag_grid \
                gunicorn

COPY dash_chorus.py /app/dash_chorus.py
COPY assets /app/assets
# COPY data /app/data
# COPY img /app/img
COPY *.sql /app
COPY *.sh /app
# COPY all_metadata.csv /pilot_meta/data/all_metadata.csv

ENTRYPOINT ["python3", "/app/dash_chorus.py"]

