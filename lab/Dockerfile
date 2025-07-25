FROM quay.io/jupyter/datascience-notebook:2024-10-02
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
USER root
ENV DATABASECONNECTOR_JAR_FOLDER=/opt/jdbc-drivers
RUN cd /tmp && \
    curl -O https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.09.0-375-amd64.deb && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
        default-jdk \
        gpg \
        bsdextrautils \
        cmake \
        flex \
        gdal-bin \
        jq \
        libcurl4-openssl-dev \
        libgdal-dev \
        libpq-dev \
        libsodium-dev \
        libsqlite3-dev \
        libssh2-1-dev \
        libssl-dev \
        libudunits2-dev \
        libxml2-dev \
        libgeos-dev \
        libproj-dev \
        pandoc \
        r-base-dev \
        r-cran-remotes \
        r-cran-renv \
        nano \
        ./*.deb && \
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends azure-cli && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf *.zip *.deb
COPY *.sh /usr/local/bin/before-notebook.d
COPY gitconfig /etc
#RUN apt-get update && \
#    apt-get install --yes --no-install-recommends \
#        r-cran-rjava && \
#    export LD_LIBRARY_PATH=/usr/lib/jvm/java-1.21.0-openjdk-amd64/lib/server:$LD_LIBRARY_PATH && \
#    ldconfig -v
USER ${NB_UID}
RUN mamba install --yes \
        jupyter-rsession-proxy \
        r-renv \
        r-rjava && \
    mamba clean --all -f -y && \
    sed -i 1,14d /opt/conda/lib/R/etc/ldpaths && \
    pip install --no-cache-dir --force-reinstall \
        git+https://github.com/TuftsCTSI/jupyter-pluto-proxy@trdw && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
ENV JULIA_DEPOT_PATH=:/opt/julia \
    JULIA_PKG_USE_CLI_GIT=true \
    JULIA_PKG_IGNORE_HASHES=true \
    JAVA_LD_LIBRARY_PATH=/usr/lib/jvm/java-11-openjdk-amd64/lib/server