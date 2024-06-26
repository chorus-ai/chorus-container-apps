FROM rocker/verse:4.3.1 AS verse
WORKDIR /site
COPY ./site .
RUN quarto render --to html --output-dir html

FROM busybox AS busybox
ADD https://github.com/OHDSI/Ares/releases/download/v0.2-beta/ares.zip .
RUN unzip ares.zip -d /ares && \
    rm -rf /ares/data

FROM ohdsi/atlas:2.13.0 AS atlas

FROM nginx:1.25.3
RUN apt-get update && \
    apt-get install --yes --no-install-recommends gpg && \
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] https://nginx.org/packages/mainline/debian/ bookworm nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends nginx-module-otel && \
    rm -rf /var/lib/apt/lists/*
COPY nginx.conf http.js /etc/nginx/
COPY access.json /etc/nginx/access/
COPY *.template /etc/nginx/templates/
COPY --from=verse /site/html /usr/share/nginx/html
COPY --from=busybox /ares /usr/share/nginx/html/ares
COPY --from=atlas /etc/nginx/conf.d/optimization.conf /etc/nginx/conf.d/optimization.conf
COPY --from=atlas /usr/share/nginx/html/atlas /usr/share/nginx/html/atlas
COPY ./atlas/config-local.js /usr/share/nginx/html/atlas/js/config-local.js
ENV SERVER_PORT=8080 \
    REMOTE_USER=- \
    OTEL_ENDPOINT=127.0.0.1:4317 \
    CHORUS_LAB_BACKEND_TEMPLATE=http://127.0.0.1:\$server_port/undefined/ \
    CHORUS_PREFECT_BACKEND=http://127.0.0.1:\$server_port/undefined/ \
    CHORUS_WEBAPI_BACKEND=http://127.0.0.1:\$server_port/undefined/ \
    NGINX_ENTRYPOINT_LOCAL_RESOLVERS=1
