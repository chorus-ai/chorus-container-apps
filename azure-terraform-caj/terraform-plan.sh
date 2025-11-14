#!/bin/bash

set -e

# Required environment variables:
# - REPO_URL: Azure DevOps repository URL (e.g., https://dev.azure.com/org/project/_git/repo)
# - AZURE_DEVOPS_PAT: Personal Access Token for Azure DevOps (or use managed identity)
# - TFE_TOKEN: Terraform Cloud/Enterprise Personal Access Token
# - WORKSPACE_DIR: Mounted directory containing terraform state (e.g., /mnt/terraform-workspace)
# - TERRAFORM_DIR: Directory containing terraform code within repo (default: .)
# - BRANCH: Git branch to checkout (default: main)

# Optional environment variables:
# - TFE_HOSTNAME: Terraform Enterprise hostname (default: app.terraform.io)
# - ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID (for Azure authentication)
# Or use managed identity with az login

echo "=================================================="
echo "Terraform Plan Container App Job"
echo "=================================================="

# Check required variables
if [ -z "$REPO_URL" ]; then
  echo "Error: REPO_URL environment variable is required"
  exit 1
fi

if [ -z "$TFE_TOKEN" ]; then
  echo "Error: TFE_TOKEN environment variable is required for Terraform Cloud/Enterprise authentication"
  exit 1
fi

if [ -z "$WORKSPACE_DIR" ]; then
  echo "Error: WORKSPACE_DIR environment variable is required (mounted directory path)"
  exit 1
fi

if [ ! -d "$WORKSPACE_DIR" ]; then
  echo "Error: WORKSPACE_DIR '$WORKSPACE_DIR' does not exist or is not mounted"
  exit 1
fi

# Set defaults
BRANCH="${BRANCH:-main}"
TERRAFORM_DIR="${TERRAFORM_DIR:-.}"
TFE_HOSTNAME="${TFE_HOSTNAME:-app.terraform.io}"

echo "Repository: $REPO_URL"
echo "Branch: $BRANCH"
echo "Terraform Directory: $TERRAFORM_DIR"
echo "Workspace Directory: $WORKSPACE_DIR"
echo "Terraform Cloud/Enterprise: $TFE_HOSTNAME"
echo ""

# Configure Terraform Cloud/Enterprise credentials
echo "Configuring Terraform Cloud/Enterprise authentication..."
mkdir -p ~/.terraform.d

cat > ~/.terraform.d/credentials.tfrc.json <<EOF
{
  "credentials": {
    "${TFE_HOSTNAME}": {
      "token": "${TFE_TOKEN}"
    }
  }
}
EOF

echo "Terraform credentials configured for ${TFE_HOSTNAME}"
echo ""

# Configure git credentials for Azure DevOps
if [ -n "$AZURE_DEVOPS_PAT" ]; then
  echo "Configuring git credentials with PAT..."
  git config --global credential.helper store
  echo "https://${AZURE_DEVOPS_PAT}@dev.azure.com" > ~/.git-credentials
elif [ -n "$AZURE_CLIENT_ID" ]; then
  echo "Authenticating with Azure Managed Identity..."
  az login --identity --client-id "$AZURE_CLIENT_ID"

  # Get Azure DevOps token from managed identity
  AZURE_DEVOPS_PAT=$(az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query accessToken --output tsv)
  git config --global credential.helper store
  echo "https://${AZURE_DEVOPS_PAT}@dev.azure.com" > ~/.git-credentials
else
  echo "Warning: No authentication configured. Attempting anonymous clone..."
fi

# Clone the repository to a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Cloning repository to temporary directory: $TEMP_DIR"
git clone --branch "$BRANCH" --depth 1 "$REPO_URL" "$TEMP_DIR/repo"

# Navigate to the terraform directory within the cloned repo
CLONE_TF_DIR="$TEMP_DIR/repo/$TERRAFORM_DIR"

if [ ! -d "$CLONE_TF_DIR" ]; then
  echo "Error: Terraform directory '$TERRAFORM_DIR' not found in repository"
  exit 1
fi

# Determine the target workspace directory (maintaining subfolder structure)
TARGET_WORKSPACE_DIR="$WORKSPACE_DIR/$TERRAFORM_DIR"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_WORKSPACE_DIR"

echo "Copying .tf and .json files from repo to workspace directory..."
echo "Source: $CLONE_TF_DIR"
echo "Target: $TARGET_WORKSPACE_DIR"

# Copy all .tf and .json files (but not .terraform directory or state files from source)
find "$CLONE_TF_DIR" -maxdepth 1 -type f \( -name "*.tf" -o -name "*.json" \) -exec cp {} "$TARGET_WORKSPACE_DIR/" \;

# Count files copied
TF_FILE_COUNT=$(find "$CLONE_TF_DIR" -maxdepth 1 -type f \( -name "*.tf" -o -name "*.json" \) | wc -l)
echo "Copied $TF_FILE_COUNT terraform files to workspace"

# Clean up temporary clone
rm -rf "$TEMP_DIR"

# Navigate to workspace directory
cd "$TARGET_WORKSPACE_DIR"

echo ""
echo "Files in workspace directory:"
ls -la

# Verify state file exists
if [ ! -f "terraform.tfstate" ] && [ ! -f ".terraform/terraform.tfstate" ]; then
  echo ""
  echo "Warning: No local terraform.tfstate file found in workspace directory"
  echo "The plan will run against an empty state or remote backend configuration"
fi

# Run terraform plan (no init needed - state already exists in mounted directory)
echo ""
echo "Running terraform plan..."
terraform plan -input=false -no-color

echo ""
echo "=================================================="
echo "Terraform plan completed successfully"
echo "=================================================="
