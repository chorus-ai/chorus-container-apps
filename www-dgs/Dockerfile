FROM rocker/verse:4.3.1 AS verse
WORKDIR /site
COPY ./site .
ADD --chmod=644 https://cdn.jsdelivr.net/npm/alpinejs@3.13.2/dist/cdn.min.js alpine@3.12.2.min.js
RUN quarto render --to html --output-dir html

FROM busybox AS busybox
ADD https://github.com/OHDSI/Ares/releases/download/v0.2-beta/ares.zip .
RUN unzip ares.zip -d /ares && \
    rm -rf /ares/data

FROM nginx:1.25.3
RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] https://nginx.org/packages/mainline/debian/ bookworm nginx" > /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends nginx-module-otel && \
    rm -rf /var/lib/apt/lists/*
COPY nginx.conf http.js /etc/nginx/
COPY access.json /etc/nginx/access/
COPY *.template /etc/nginx/templates/
COPY *.sh /docker-entrypoint.d/
COPY --from=verse /site/html /usr/share/nginx/html
COPY --from=busybox /ares /usr/share/nginx/html/ares
ENV SERVER_PORT=8080 \
    REMOTE_USER=- \
    OTEL_ENDPOINT=127.0.0.1:4317 \
    UPLOADS_CLIENT_MAX_BODY_SIZE=1g
