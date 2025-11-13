# Terraform Plan Container App Job

This container is designed to run as an Azure Container App Job that:
1. Clones Terraform configuration files (.tf and .json) from an Azure DevOps repository
2. Copies them to a mounted workspace directory containing existing Terraform state
3. Runs `terraform plan` against the existing state to show what changes would be made

This workflow is ideal when you want to:
- Manage Terraform state separately (in a mounted volume or Azure Files)
- Update only the Terraform configuration files without reinitializing
- Run plans against existing infrastructure state

## Features

- Based on official HashiCorp Terraform image
- Git support for cloning Azure DevOps repositories
- Azure CLI pre-installed for Azure authentication
- Supports authentication via PAT token or Azure Managed Identity

## Prerequisites

### Terraform Cloud/Enterprise Token

Create a Personal Access Token in Terraform Cloud:
1. Log in to [Terraform Cloud](https://app.terraform.io)
2. Go to User Settings → Tokens
3. Click "Create an API token"
4. Give it a description (e.g., "Azure Container App Job")
5. Copy the token (you'll need this for the `TFE_TOKEN` environment variable)

For Terraform Enterprise, use your custom hostname instead of `app.terraform.io` and set the `TFE_HOSTNAME` environment variable.

## Usage

The container includes a script at `/usr/local/bin/terraform-plan.sh` that handles the entire workflow.

### Environment Variables

#### Required
- `REPO_URL`: Azure DevOps repository URL (e.g., `https://dev.azure.com/org/project/_git/repo`)
- `TFE_TOKEN`: Terraform Cloud/Enterprise Personal Access Token
- `WORKSPACE_DIR`: Path to mounted directory containing Terraform state (e.g., `/mnt/terraform-workspace`)

#### Azure DevOps Authentication (choose one)
- `AZURE_DEVOPS_PAT`: Personal Access Token for Azure DevOps
- `AZURE_CLIENT_ID`: Client ID for Azure Managed Identity authentication

#### Optional
- `BRANCH`: Git branch to checkout (default: `main`)
- `TERRAFORM_DIR`: Directory containing terraform code within the repo (default: `.`)
- `TFE_HOSTNAME`: Terraform Enterprise hostname (default: `app.terraform.io`)

#### Azure Provider Authentication
For Terraform to authenticate with Azure, provide one of:
- **Service Principal**: `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`
- **Managed Identity**: Set `ARM_USE_MSI=true` and configure managed identity on the Container App Job

**Note**: When using Terraform Cloud/Enterprise with remote state, Azure credentials may be configured in the workspace settings instead of environment variables.

## Setting Up the Workspace Volume

First, create an Azure Files share or persistent volume to store your Terraform state:

```bash
# Create storage account and file share
az storage account create \
  --name <storage-account-name> \
  --resource-group <your-rg> \
  --sku Standard_LRS

az storage share create \
  --name terraform-workspace \
  --account-name <storage-account-name>

# Get storage key
STORAGE_KEY=$(az storage account keys list \
  --account-name <storage-account-name> \
  --query "[0].value" -o tsv)

# Add storage to Container App environment
az containerapp env storage set \
  --name <your-env> \
  --resource-group <your-rg> \
  --storage-name terraform-state \
  --azure-file-account-name <storage-account-name> \
  --azure-file-account-key $STORAGE_KEY \
  --azure-file-share-name terraform-workspace \
  --access-mode ReadWrite
```

## Azure Container App Job Example

```bash
az containerapp job create \
  --name terraform-plan-job \
  --resource-group <your-rg> \
  --environment <your-env> \
  --trigger-type Manual \
  --replica-timeout 1800 \
  --replica-retry-limit 0 \
  --parallelism 1 \
  --replica-completion-count 1 \
  --image ghcr.io/chorus-ai/chorus-az-tfcaj:main \
  --cpu 1.0 \
  --memory 2Gi \
  --secrets \
    azure-devops-pat=<your-pat-token> \
    tfe-token=<your-terraform-cloud-token> \
    arm-client-secret=<your-service-principal-secret> \
  --env-vars \
    REPO_URL=https://dev.azure.com/yourorg/yourproject/_git/yourrepo \
    BRANCH=main \
    TERRAFORM_DIR=terraform/environments/dev \
    WORKSPACE_DIR=/mnt/terraform-workspace \
    TFE_HOSTNAME=app.terraform.io \
    ARM_CLIENT_ID=<client-id> \
    ARM_TENANT_ID=<tenant-id> \
    ARM_SUBSCRIPTION_ID=<subscription-id> \
  --secrets-env-vars \
    AZURE_DEVOPS_PAT=azure-devops-pat \
    TFE_TOKEN=tfe-token \
    ARM_CLIENT_SECRET=arm-client-secret \
  --command "/usr/local/bin/terraform-plan.sh"

# Mount the storage after creation
az containerapp job update \
  --name terraform-plan-job \
  --resource-group <your-rg> \
  --set properties.template.volumes[0].name=terraform-state \
  --set properties.template.volumes[0].storageName=terraform-state \
  --set properties.template.containers[0].volumeMounts[0].volumeName=terraform-state \
  --set properties.template.containers[0].volumeMounts[0].mountPath=/mnt/terraform-workspace
```

## Running the Job

Execute the job manually:
```bash
az containerapp job start --name terraform-plan-job --resource-group <your-rg>
```

View job execution logs:
```bash
az containerapp job execution list --name terraform-plan-job --resource-group <your-rg> --output table

# Get logs from specific execution
az containerapp job logs show --name terraform-plan-job --resource-group <your-rg> --execution <execution-name>
```

## Local Testing

Build the image:
```bash
docker build -t terraform-plan:latest .
```

Run locally (with mounted workspace directory):
```bash
# Create a local workspace directory with state
mkdir -p /tmp/terraform-workspace
# Add your terraform.tfstate file to this directory

docker run --rm \
  -v /tmp/terraform-workspace:/mnt/workspace \
  -e REPO_URL=https://dev.azure.com/yourorg/yourproject/_git/yourrepo \
  -e AZURE_DEVOPS_PAT=<your-pat> \
  -e TFE_TOKEN=<your-terraform-cloud-token> \
  -e WORKSPACE_DIR=/mnt/workspace \
  -e BRANCH=main \
  -e ARM_CLIENT_ID=<client-id> \
  -e ARM_CLIENT_SECRET=<client-secret> \
  -e ARM_TENANT_ID=<tenant-id> \
  -e ARM_SUBSCRIPTION_ID=<subscription-id> \
  terraform-plan:latest \
  /usr/local/bin/terraform-plan.sh
```

## Scheduling

To run this job on a schedule, use a scheduled trigger:

```bash
az containerapp job create \
  --name terraform-plan-scheduled \
  --resource-group <your-rg> \
  --environment <your-env> \
  --trigger-type Schedule \
  --cron-expression "0 0 * * *" \
  --replica-timeout 1800 \
  # ... rest of configuration
```

This would run the terraform plan daily at midnight UTC.
