#!/usr/bin/env bash

set -e
set -u

set -o pipefail

if [[ $# -eq 0 ]]; then
    ENTRY_COMMAND="web"
else
    ENTRY_COMMAND="$1"
fi

echo "Launching Entrypoint ->${ENTRY_COMMAND}"

if [[ $ENTRY_COMMAND == "" ]]; then
 exit 0
elif [[ $ENTRY_COMMAND == "web" ]]; then
  service nginx start
  # https://oauth2-proxy.github.io/oauth2-proxy/configuration
  /usr/bin/oauth2-proxy --client-id="${OAUTH2_CLIENT_ID}" \
             --client-secret="${OAUTH2_CLIENT_SECRET}" \
             --provider="${OAUTH2_PROVIDER}" \
             --cookie-secret="${OAUTH2_COOKIE_SECRET}" \
             --cookie-secure=false \
             --force-https=false \
             --set-xauthrequest=true \
             --redirect-url="${OAUTH2_REDIRECT_URL}" \
             --email-domain="${OAUTH2_EMAIL_DOMAIN}" --upstream file:///dev/null &

  sleep infinity
else
  # Non blocking entrypoint starting bash
  exec "$@"
fi