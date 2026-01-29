#!/bin/bash
# verify-version.sh - Verify infrastructure version consistency

set -e

ENVIRONMENT=${1:-dev}
GIT_TAG=${2:-""}

echo "🔍 Verifying infrastructure version for environment: $ENVIRONMENT"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get version from git tag (if provided)
if [ -n "$GIT_TAG" ]; then
    EXPECTED_VERSION=$(echo $GIT_TAG | sed 's/infra-//')
    echo "📌 Expected version from git tag: $EXPECTED_VERSION"
else
    # Get latest tag from main branch
    EXPECTED_VERSION=$(git describe --tags --abbrev=0 main 2>/dev/null || echo "unknown")
    echo "📌 Latest git tag: $EXPECTED_VERSION"
fi

# Get version from Terraform state
echo "🔎 Checking Terraform state..."
cd terraform/environments/$ENVIRONMENT

if [ -f "terraform.tfstate" ] || [ -f ".terraform/terraform.tfstate" ]; then
    TERRAFORM_VERSION=$(terraform output -json infrastructure_version 2>/dev/null | jq -r '.' || echo "not-found")
    echo "📦 Terraform state version: $TERRAFORM_VERSION"
else
    TERRAFORM_VERSION="state-not-found"
    echo "⚠️  Terraform state not found locally (may be in remote backend)"
fi

# Get version from Azure resources (sample - using Azure CLI)
echo "☁️  Checking Azure resources..."
if command -v az &> /dev/null; then
    AZURE_VERSION=$(az resource list \
        --tag Environment=$ENVIRONMENT \
        --query "[?tags.ManagedBy=='Terraform'].tags.Version" \
        -o tsv 2>/dev/null | head -1 || echo "not-found")
    echo "☁️  Azure resource version: $AZURE_VERSION"
else
    AZURE_VERSION="az-cli-not-installed"
    echo "⚠️  Azure CLI not installed, skipping Azure check"
fi

# Compare versions
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Version Comparison:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Git Tag:        $EXPECTED_VERSION"
echo "Terraform:      $TERRAFORM_VERSION"
echo "Azure:          $AZURE_VERSION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check if versions match
MATCH=true
if [ "$EXPECTED_VERSION" != "$TERRAFORM_VERSION" ] && [ "$TERRAFORM_VERSION" != "not-found" ] && [ "$TERRAFORM_VERSION" != "state-not-found" ]; then
    echo -e "${RED}❌ Git and Terraform versions do not match!${NC}"
    MATCH=false
fi

if [ "$EXPECTED_VERSION" != "$AZURE_VERSION" ] && [ "$AZURE_VERSION" != "not-found" ] && [ "$AZURE_VERSION" != "az-cli-not-installed" ]; then
    echo -e "${RED}❌ Git and Azure versions do not match!${NC}"
    MATCH=false
fi

if [ "$MATCH" = true ]; then
    echo -e "${GREEN}✅ All versions match!${NC}"
    exit 0
else
    echo -e "${RED}❌ Version mismatch detected!${NC}"
    exit 1
fi
