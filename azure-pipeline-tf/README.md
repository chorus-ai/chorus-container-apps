# Azure Pipeline Terraform Runner

This directory contains a containerized Azure Pipelines agent configured for running Terraform operations like plan and apply in Azure Container Apps.

## Features

- Based on official HashiCorp Terraform image
- Azure CLI pre-installed
- Supports authentication via PAT token or Azure Managed Identity
- Runs as a self-hosted Azure Pipelines agent
- Executes one job and then terminates (--once flag)

## Important: Architecture Requirements

**This container MUST run on linux/amd64 (x64) architecture.**

Azure Pipelines agents are only available for x64 architecture, not ARM64. If you try to run this on ARM64, you'll get relocation errors like:
```
Error relocating ./bin/libSystem.IO.Compression.Native.so: unsupported relocation type
```

Ensure your Azure Container App is deployed with the `--platform linux/amd64` flag or workload profile that supports x64.

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

2. Create Container App (ensure you're using a workload profile that supports x64/amd64):
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
  --max-replicas 10 \
  --workload-profile-name "Consumption"
```

**Note:** Azure Container Apps Consumption plans use x64 architecture by default. If you're using a Dedicated workload profile, ensure it's configured for x64.

3. Grant the Managed Identity access to your Azure DevOps organization by following the [official documentation](https://learn.microsoft.com/en-us/azure/devops/integrate/get-started/authentication/service-principal-managed-identity).

## How It Works

1. Container starts and runs `azp.sh`
2. Script authenticates with Azure DevOps (via PAT or Managed Identity)
3. Downloads and configures the latest Azure Pipelines agent
4. Registers agent with specified pool
5. Runs one pipeline job
6. Unregisters agent and terminates

This "run-once" pattern is ideal for Container Apps with autoscaling, ensuring clean agent state for each job.

## Troubleshooting

### Authentication Error: "could not determine a matching Azure Pipelines agent"

This error occurs when the agent cannot authenticate with Azure DevOps. Check the following:

1. **Verify PAT Token Permissions**
   - Go to Azure DevOps > User Settings > Personal Access Tokens
   - Ensure your token has the `Agent Pools (Read & manage)` scope
   - Check that the token hasn't expired

2. **Verify Environment Variables in Container App**
   - `AZP_TOKEN` should be set as a secret
   - `AZP_URL` should be in the format `https://dev.azure.com/YourOrganization`
   - Check the Container App logs to see if variables are being loaded

3. **Test Token Manually**
   ```bash
   curl -u user:YOUR_PAT_TOKEN \
     -H 'Accept:application/json;' \
     'https://dev.azure.com/YourOrg/_apis/distributedtask/packages/agent?platform=linux-x64&top=1'
   ```
   This should return JSON with agent package information.

4. **Common Issues**
   - Token has incorrect scopes (needs Agent Pools permission)
   - Organization name is incorrect in AZP_URL
   - Token was revoked or expired
   - Container App secret wasn't configured correctly
