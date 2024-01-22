FROM node:lts AS node
ADD https://github.com/PrefectHQ/prefect/archive/refs/tags/2.12.1.tar.gz .
RUN tar -xf *.tar.gz --strip-components=1 && \
    cd /ui && \
    npm ci && \
    PREFECT_UI_SERVE_BASE="/prefect/" npm run build

FROM prefecthq/prefect:2.12.1-python3.10
COPY --from=node /ui/dist /usr/local/lib/python3.10/site-packages/prefect/server/ui
ENV PREFECT_SERVER_ANALYTICS_ENABLED=False \
    PREFECT_SERVER_API_HOST=0.0.0.0
CMD ["prefect", "server", "start"]
