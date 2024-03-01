FROM busybox AS builder
ADD https://github.com/OHDSI/Ares/releases/download/v0.3-beta/Ares.0.3-beta.zip .
RUN unzip Ares.0.3-beta.zip -d /ares
RUN mv /ares/data /data

FROM nginx:1.22-alpine as server

COPY --from=builder /ares /usr/share/nginx/html/ares
COPY --from=builder /ares/index.html /usr/share/nginx/html/index.html
COPY --from=builder /data /usr/share/nginx/html/data
