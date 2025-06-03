FROM python:3.11-bullseye
# Pin python3.11 for omop alchemy
ENV LANG=C.UTF-8
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        default-jdk \
        pandoc \
        postgresql-client \
        python3-dev \
        tini \
        fuse3 \
        libfuse3-dev \
        gcc \
        jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone https://github.com/AustralianCancerDataNetwork/OMOP_Alchemy.git
RUN pip install /tmp/OMOP_Alchemy
WORKDIR /opt/etl
RUN pip install pip==23.2.1 setuptools==68.1.2
#COPY requirements.txt .
#RUN pip install --no-cache-dir -r requirements.txt
# Note - add requirements.txt file with any additional Python packages to include and uncomment above
RUN pip install --upgrade pip ipython ipykernel
