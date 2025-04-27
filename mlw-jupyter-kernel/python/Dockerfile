FROM buildpack-deps:22.04
ENV LANG=C.UTF-8
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli jammy main" > /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
        default-jdk \
        pandoc \
        postgresql-client \
        python-is-python3 \
        python3-pip \
        python3-dev \
        tini \
        fuse3 \
        libfuse3-dev \
        gcc \
        jq && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /opt/etl
RUN pip install pip==23.2.1 setuptools==68.1.2
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --upgrade pip ipython ipykernel
