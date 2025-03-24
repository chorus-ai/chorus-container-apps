FROM ghcr.io/chorus-ai/chorus-etl:main

COPY requirements.txt .

RUN python3 -m pip3 install --no-cache-dir --upgrade pip setuptools && \
  python3 -m pip3 install --no-cache-dir -r requirements.txt
