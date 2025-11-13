FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAFORM_VERSION=1.9.8

# Install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    jq \
    git \
    ca-certificates \
    unzip \
    wget \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && terraform --version

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Create working directory for the agent
RUN mkdir -p /opt/azp

# Copy the agent startup script
COPY azp.sh /opt/azp/azp.sh
RUN chmod +x /opt/azp/azp.sh

# Set working directory
WORKDIR /opt/azp

# Set entrypoint
ENTRYPOINT ["/opt/azp/azp.sh"]