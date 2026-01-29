# Development Environment - Main Configuration

terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  # Backend configuration moved to backend.tf
  # See backend.tf for remote state configuration
}

provider "azurerm" {
  features {}
  
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Resource Group
module "resource_group" {
  source = "../../shared"
  
  environment = "dev"
  project_name = var.project_name
  location = var.location
}

# Key Vault
module "key_vault" {
  source = "../../modules/key-vault"
  
  environment = "dev"
  project_name = var.project_name
  location = var.location
  resource_group_name = module.resource_group.name
  
  tags = local.common_tags
}

# Cosmos DB
module "cosmos_db" {
  source = "../../modules/cosmos-db"
  
  environment = "dev"
  project_name = var.project_name
  location = var.location
  resource_group_name = module.resource_group.name
  
  throughput = 400  # Dev: Lower throughput
  enable_autoscale = false
  
  tags = local.common_tags
}

# App Service (Backend)
module "app_service" {
  source = "../../modules/app-service"
  
  environment = "dev"
  project_name = var.project_name
  location = var.location
  resource_group_name = module.resource_group.name
  
  app_service_plan_sku = "B1"  # Dev: Basic tier
  node_version = "18"
  
  cosmos_db_endpoint = module.cosmos_db.endpoint
  cosmos_db_key = module.cosmos_db.primary_key
  key_vault_id = module.key_vault.id
  
  tags = local.common_tags
}

# Static Web App (Frontend)
module "static_web_app" {
  source = "../../modules/static-web-app"
  
  environment = "dev"
  project_name = var.project_name
  location = var.location
  resource_group_name = module.resource_group.name
  
  app_service_api_url = module.app_service.url
  
  tags = local.common_tags
}

# Monitoring
module "monitoring" {
  source = "../../modules/monitoring"
  
  environment = "dev"
  project_name = var.project_name
  resource_group_name = module.resource_group.name
  
  app_service_id = module.app_service.id
  static_web_app_id = module.static_web_app.id
  
  tags = local.common_tags
}

# Local values
locals {
  common_tags = {
    Environment     = "dev"
    Project         = var.project_name
    Version         = var.infrastructure_version
    GitCommit       = var.git_commit_sha
    GitTag          = var.git_tag
    ManagedBy       = "Terraform"
    Repository      = var.repository_url
    DeployedAt      = timestamp()
  }
}
