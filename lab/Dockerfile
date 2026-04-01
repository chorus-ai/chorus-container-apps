FROM quay.io/jupyter/datascience-notebook:2026-03-23
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
USER root
ENV DATABASECONNECTOR_JAR_FOLDER=/opt/jdbc-drivers
RUN cd /tmp && \
    curl -O https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2026.01.2-418-amd64.deb && \
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
        libcairo2-dev \
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
        libharfbuzz-dev \
        libfribidi-dev \
        libfreetype6-dev \
        libpng-dev \
        librsvg2-dev \
        libtiff5-dev \
        libreoffice \
        nano \
        pandoc \
        postgresql-client \
        r-base-dev \
        r-cran-remotes \
        r-cran-renv \
        unixodbc-dev \
        ./*.deb && \
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends azure-cli && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf *.zip *.deb
COPY *.sh /usr/local/bin/before-notebook.d
COPY gitconfig /etc

USER ${NB_UID}
RUN mamba install --yes \
        jupyter-rsession-proxy \
        r-renv \
        r-rsvg \
        r-rpostgres \
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
USER root
RUN mkdir -p /opt/ijava-jars && \
    cd /opt/ijava-jars && \
    curl -O https://repo1.maven.org/maven2/javax/xml/soap/javax.xml.soap-api/1.4.0/javax.xml.soap-api-1.4.0.jar && \
    mv javax.xml.soap-api-1.4.0.jar soap.jar && \
    curl -O https://repo1.maven.org/maven2/org/apache/poi/poi/3.12-beta1/poi-3.12-beta1.jar && \
    mv poi-3.12-beta1.jar poi-3.12-beta1-20150228.jar && \
    curl -O https://repo1.maven.org/maven2/org/apache/poi/poi-ooxml/3.12-beta1/poi-ooxml-3.12-beta1.jar && \
    mv poi-ooxml-3.12-beta1.jar poi-ooxml-3.12-beta1-20150228.jar && \
    curl -O https://repo1.maven.org/maven2/org/apache/poi/poi-ooxml-schemas/3.12-beta1/poi-ooxml-schemas-3.12-beta1.jar && \
    mv poi-ooxml-schemas-3.12-beta1.jar poi-ooxml-schemas-3.12-beta1-20150228.jar && \
    curl -O https://jdbc.postgresql.org/download/postgresql-42.7.8.jar && \
    curl -O https://repo1.maven.org/maven2/org/apache/pdfbox/pdfbox-app/2.0.3/pdfbox-app-2.0.3.jar && \
    curl -O https://repo1.maven.org/maven2/xerces/xercesImpl/2.12.2/xercesImpl-2.12.2.jar && \
    mv xercesImpl-2.12.2.jar xercesImpl.jar && \
    curl -O https://repo1.maven.org/maven2/org/apache/xmlbeans/xmlbeans/5.2.0/xmlbeans-5.2.0.jar && \
    mv xmlbeans-5.2.0.jar xbean.jar && \
    curl -O https://repo1.maven.org/maven2/dom4j/dom4j/1.6.1/dom4j-1.6.1.jar && \
    curl -O https://repo1.maven.org/maven2/org/jsoup/jsoup/1.8.1/jsoup-1.8.1.jar && \
    curl -O https://repo1.maven.org/maven2/javax/media/jai_codec/1.1.3/jai_codec-1.1.3.jar && \
    mv jai_codec-1.1.3.jar jai_codec.jar && \
    curl -O https://repo1.maven.org/maven2/javax/media/jai_core/1.1.3/jai_core-1.1.3.jar && \
    mv jai_core-1.1.3.jar jai_core.jar && \
    chown -R ${NB_UID}:${NB_GID} /opt/ijava-jars

USER ${NB_UID}
RUN cd /tmp && \
    curl -L https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip -o ijava.zip && \
    unzip ijava.zip && \
    python install.py --sys-prefix && \
    rm -rf /tmp/ijava.zip /tmp/install.py /tmp/java && \
    mkdir -p /home/${NB_USER}/.ijava && \
    echo '{"classpath": ["/opt/ijava-jars/*"]}' > /home/${NB_USER}/.ijava/config.json && \
    fix-permissions "/home/${NB_USER}"
