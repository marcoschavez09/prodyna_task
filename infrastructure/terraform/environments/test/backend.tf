# Backend Configuration for Test Environment

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-test"
    storage_account_name = "stterraformstatetest"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
  }
}
