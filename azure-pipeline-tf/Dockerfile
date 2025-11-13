FROM hashicorp/terraform:latest

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    jq \
    git \
    ca-certificates \
    openssl \
    python3 \
    py3-pip \
    && update-ca-certificates

# Install Azure CLI
RUN pip3 install --no-cache-dir azure-cli --break-system-packages

# Create working directory for the agent
RUN mkdir -p /opt/azp

# Copy the agent startup script
COPY azp.sh /opt/azp/azp.sh
RUN chmod +x /opt/azp/azp.sh

# Set working directory
WORKDIR /opt/azp

# Set entrypoint
ENTRYPOINT ["/opt/azp/azp.sh"]