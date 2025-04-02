FROM buildpack-deps:22.04
ENV LANG=C.UTF-8
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        default-jdk \
        pandoc \
        postgresql-client \
        r-base \
        r-base-dev \
        r-cran-remotes \
        tini \
        jq && \
    rm -rf /var/lib/apt/lists/*
RUN --mount=type=secret,id=GPAT,env=GITHUB_PAT Rscript -e 'remotes::install_github("OHDSI/Hades")'
RUN --mount=type=secret,id=GPAT,env=GITHUB_PAT Rscript -e 'remotes::install_github("OHDSI/DataQualityDashboard")'
RUN --mount=type=secret,id=GPAT,env=GITHUB_PAT Rscript -e 'remotes::install_github("OHDSI/Achilles")'
RUN --mount=type=secret,id=GPAT,env=GITHUB_PAT Rscript -e 'remotes::install_github("IRkernel/IRkernel")'
ENV DATABASECONNECTOR_JAR_FOLDER=/opt/jdbc-drivers
RUN Rscript -e 'DatabaseConnector::downloadJdbcDrivers("all")'
