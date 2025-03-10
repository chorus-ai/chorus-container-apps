from alpine:latest

RUN --mount=type=secret,id=USER_CREDS "echo \"$(cat /run/secrets/USER_CREDS)\" >> /tmp/creds.txt"
