FROM hashicorp/terraform:latest

# Install dependencies for git, Azure CLI, and Azure DevOps authentication
RUN apk add --no-cache \
    bash \
    git \
    curl \
    jq \
    openssh-client \
    ca-certificates \
    python3 \
    py3-pip \
    && update-ca-certificates

# Install Azure CLI
RUN pip3 install --no-cache-dir azure-cli --break-system-packages

# Create working directory
RUN mkdir -p /workspace

# Copy terraform plan script
COPY terraform-plan.sh /usr/local/bin/terraform-plan.sh
RUN chmod +x /usr/local/bin/terraform-plan.sh

# Set working directory
WORKDIR /workspace

# Default command (can be overridden by Container App Job)
CMD ["/bin/sh"]
