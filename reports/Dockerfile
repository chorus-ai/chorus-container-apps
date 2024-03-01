FROM ghcr.io/chorus-ai/chorus-etl:main
LABEL maintainer="Tufts Medical Center <jared.houghtaling@tuftsmedicine.org>"
USER root

RUN Rscript -e 'remotes::install_version("renv", "1.0.2")'
COPY renv.lock .
RUN Rscript -e 'renv::restore()'

RUN Rscript -e 'remotes::install_github("chorus-ai/CHoRUSReports")'

COPY ["entrypoint.sh", "CHoRUSReports.R", "/app/"]

ENTRYPOINT ["/app/entrypoint.sh"]
