FROM python:3.13-bookworm

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        postgresql-client && \
    rm -rf /var/lib/apt/lists/*

COPY *.sql /app/
COPY job/refresh_data.py /app/refresh_data.py

ENTRYPOINT ["python3", "/app/refresh_data.py"]
