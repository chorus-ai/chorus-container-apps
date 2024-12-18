# Install essential system dependencies
RUN apt-get update && apt-get install --yes --no-install-recommends \
    python3-pip \
    tini \
    && rm -rf /var/lib/apt/lists/*

# Install specific Python package versions
RUN pip install --no-cache-dir --upgrade pip setuptools \
    && pip install --no-cache-dir -r requirements.txt

# Use tini as the entrypoint for better process management
ENTRYPOINT ["/usr/bin/tini", "--"]