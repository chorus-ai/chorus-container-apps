FROM quay.io/jupyter/datascience-notebook:2024-01-08
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
USER root
COPY *.sh /usr/local/bin/before-notebook.d
COPY gitconfig /etc
ENV DATABASECONNECTOR_JAR_FOLDER=/opt/jdbc-drivers
RUN cd /tmp && \
    mkdir -p ${DATABASECONNECTOR_JAR_FOLDER} && \
    curl -O https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2023.09.1-494-amd64.deb && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
        default-jdk \
        gpg \
        vim \
        ./*.deb && \
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends azure-cli && \
    rm -rf /var/lib/apt/lists/* && \
    rm *.zip *.deb
USER ${NB_UID}
RUN mamba install --yes \
        jupyter-rsession-proxy \
        r-renv && \
    mamba clean --all -f -y && \
    sed -i 1,14d /opt/conda/lib/R/etc/ldpaths && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
ENV JAVA_LD_LIBRARY_PATH=/usr/lib/jvm/java-11-openjdk-amd64/lib/server
