from ohdsi/broadsea-hades:4.2.1

COPY secret.sh /tmp/secret.sh
RUN chmod +x /tmp/secret.sh
RUN --mount=type=secret,id=USER_CREDS /tmp/secret.sh "$(cat /run/secrets/USER_CREDS)"
