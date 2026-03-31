FROM python:3.12-bookworm

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        cargo && \
    rm -rf /var/lib/apt/lists/*

RUN pip install azure-identity \
                azure-mgmt-resource \
                msgraph-sdk \
                pandas \
                requests

COPY read_access_chorus.py /app/read_access_chorus.py

ENTRYPOINT ["python3", "/app/read_access_chorus.py"]

