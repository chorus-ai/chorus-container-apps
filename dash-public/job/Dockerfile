FROM python:3.13-bookworm
# Potentially bump image version in future
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY *.sql /app/
COPY refresh_data.py /app/refresh_data.py

ENTRYPOINT ["python3", "/app/refresh_data.py"]
