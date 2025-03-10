from alpine:latest

RUN --mount=type=secret,id=USER_CREDS "$(cat /run/secrets/USER_CREDS >> /tmp/creds.txt)"
"
