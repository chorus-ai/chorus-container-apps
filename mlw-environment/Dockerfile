from ubuntu/python:3.12-24.04_stable

COPY requirements.txt .

RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools && \
  python3 -m pip install --no-cache-dir -r requirements.txt

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        git-all \
        unzip

CMD ["jupyterhub", "-f", "/etc/jupyterhub/jupyterhub_config.py"]
