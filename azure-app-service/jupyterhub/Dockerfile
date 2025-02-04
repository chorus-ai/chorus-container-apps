from jupyterhub/jupyterhub:5.2.1

COPY secret.sh /tmp/secret.sh
COPY requirements.txt .

RUN mkdir /etc/jupyterhub && \
  python3 -m pip install --upgrade jupyterlab && \
  python3 -m pip install --no-cache-dir --upgrade pip setuptools && \
  python3 -m pip install --no-cache-dir -r requirements.txt

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        git-all

COPY jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py

RUN --mount=type=secret,id=USER_CREDS /tmp/secret.sh "$(cat /run/secrets/USER_CREDS)"

CMD ["jupyterhub", "-f", "/etc/jupyterhub/jupyterhub_config.py"]
