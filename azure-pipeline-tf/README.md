# Azure Pipeline Terraform Runner

This directory contains a containerized Azure Pipelines agent configured for running Terraform operations in Azure Container Apps.

## Features

- Based on official HashiCorp Terraform image
- Azure CLI pre-installed
- Supports authentication via PAT token or Azure Managed Identity
- Runs as a self-hosted Azure Pipelines agent
- Executes one job and then terminates (--once flag)

## Building the Image

```bash
docker build -t azure-pipeline-tf:latest .
```

## Environment Variables

### Required
- `AZP_URL`: The URL of your Azure DevOps organization (e.g., `https://dev.azure.com/yourorg`)

### Authentication (choose one)
- `AZP_TOKEN`: Personal Access Token for Azure DevOps
- `AZP_TOKEN_FILE`: Path to a file containing the PAT token
- `AZURE_CLIENT_ID`: Client ID for Azure Managed Identity authentication

### Optional
- `AZP_AGENT_NAME`: Name for the agent (defaults to hostname)
- `AZP_POOL`: Agent pool name (defaults to "Default")
- `AZP_WORK`: Working directory for the agent (defaults to "_work")
- `AZP_PLACEHOLDER`: Set to any value to run in placeholder mode (agent won't execute jobs)

## Running Locally

With PAT token:
```bash
docker run -e AZP_URL="https://dev.azure.com/yourorg" \
           -e AZP_TOKEN="your-pat-token" \
           -e AZP_POOL="Terraform" \
           azure-pipeline-tf:latest
```

## Deploying to Azure Container Apps

1. Build and push to Azure Container Registry:
```bash
az acr build --registry <your-acr-name> \
             --image azure-pipeline-tf:latest \
             .
```

2. Create Container App with Managed Identity:
```bash
az containerapp create \
  --name pipeline-tf-runner \
  --resource-group <your-rg> \
  --environment <your-env> \
  --image <your-acr>.azurecr.io/azure-pipeline-tf:latest \
  --registry-server <your-acr>.azurecr.io \
  --system-assigned \
  --env-vars \
    AZP_URL="https://dev.azure.com/yourorg" \
    AZP_POOL="Terraform" \
    AZURE_CLIENT_ID="<managed-identity-client-id>" \
  --cpu 1.0 \
  --memory 2Gi \
  --min-replicas 0 \
  --max-replicas 10
```

3. Grant the Managed Identity access to your Azure DevOps organization by following the [official documentation](https://learn.microsoft.com/en-us/azure/devops/integrate/get-started/authentication/service-principal-managed-identity).

## How It Works

1. Container starts and runs `azp.sh`
2. Script authenticates with Azure DevOps (via PAT or Managed Identity)
3. Downloads and configures the latest Azure Pipelines agent
4. Registers agent with specified pool
5. Runs one pipeline job
6. Unregisters agent and terminates

This "run-once" pattern is ideal for Container Apps with autoscaling, ensuring clean agent state for each job.
