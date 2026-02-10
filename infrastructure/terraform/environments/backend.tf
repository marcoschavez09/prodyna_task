# Backend Configuration for Dev Environment
# This file can be separate or included in main.tf
# Using separate file for clarity

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-dev"
    storage_account_name = "stterraformstatedev"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    
    # Optional: Enable state locking
    # Use Azure Storage Account blob leasing for state locking
    # This prevents concurrent modifications
  }
}

# Note: Backend configuration cannot use variables
# Storage account must be created via bootstrap first
# See: ../../bootstrap/README.md
