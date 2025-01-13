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

COPY read_access_chorus.py /app/read_access_chorus.py

ENTRYPOINT ["python3", "/app/read_access_chorus.py"]

