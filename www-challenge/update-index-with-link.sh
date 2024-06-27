#!/bin/sh
# vim:sw=4:ts=4:et

set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

ME=$(basename "$0")

entrypoint_log "$ME: Updating index with dynamic link..."
sed "s|ML_WORKSPACE_URL|${ML_WORKSPACE_URL}|g" -i /usr/share/nginx/html/index.html
exit 0

