FROM rocker/verse:latest AS verse
WORKDIR /site
COPY site .
RUN quarto render --to html --output-dir html

FROM busybox AS busybox
ADD https://github.com/OHDSI/Ares/releases/download/v0.2-beta/ares.zip .
RUN unzip ares.zip -d /ares && \
    rm -rf /ares/data

# FROM ohdsi/atlas:2.13.0 AS atlas

FROM nginx:1.25.3
RUN apt-get update && \
    apt-get install --yes --no-install-recommends gpg && \
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
RUN apt-get update && \
    apt-get install --yes --no-install-recommends jq && \
      curl -L --silent \
      $(curl --silent "https://api.github.com/repos/oauth2-proxy/oauth2-proxy/releases/latest" \
      | jq  -r '.assets[] | select(.name | contains("linux-amd64")).browser_download_url' \
      | grep ".tar.gz") \
      | tar -xz --strip-components 1 && mv oauth2_proxy /usr/bin/ && \
      rm -rf /var/lib/apt/lists/*
COPY nginx.conf http.js /etc/nginx/
COPY *.template /etc/nginx/templates/
COPY --from=verse /site/html /usr/share/nginx/html
COPY --from=busybox /ares /usr/share/nginx/html/ares
WORKDIR /app/
COPY ./entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
#COPY --from=atlas /etc/nginx/conf.d/optimization.conf /etc/nginx/conf.d/optimization.conf
#COPY --from=atlas /usr/share/nginx/html/atlas /usr/share/nginx/html/atlas
#COPY atlas/config-local.js /usr/share/nginx/html/atlas/js/config-local.js
ENV SERVER_PORT=8080 \
    REMOTE_USER=- \
    NGINX_ENTRYPOINT_LOCAL_RESOLVERS=1 \
    OAUTH2_CLIENT_ID=- \
    OAUTH2_CLIENT_SECRET=- \
    OAUTH2_PROVIDER=- \
    OAUTH2_COOKIE_SECRET=- \
    FORCE_HTTPS=- \
    OAUTH2_EMAIL_DOMAIN=-
