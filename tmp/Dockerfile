from ubuntu:latest

RUN --mount=type=secret,id=USER_CREDS "$(cat /run/secrets/USER_CREDS >> /etc/creds.txt)"
