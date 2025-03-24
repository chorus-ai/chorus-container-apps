FROM buildpack-deps:22.04
ENV LANG=C.UTF-8
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli jammy main" > /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
        azure-cli \
        default-jdk \
        pandoc \
        postgresql-client \
        python-is-python3 \
        python3-pip \
        r-base \
        r-base-dev \
        r-cran-remotes \
        tini \
        jq && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /opt/etl
RUN Rscript -e 'remotes::install_version("renv", "1.0.2")'
COPY renv.lock .
RUN Rscript -e 'renv::restore()'
ENV DATABASECONNECTOR_JAR_FOLDER=/opt/jdbc-drivers
RUN Rscript -e 'DatabaseConnector::downloadJdbcDrivers("all")'
RUN pip install pip==23.2.1 setuptools==68.1.2
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \ 
    fuse3 \
    libfuse3-dev \
    gcc
