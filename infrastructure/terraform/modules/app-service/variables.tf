variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "app_service_plan_sku" {
  description = "App Service Plan SKU"
  type        = string
  default     = "B1"
}

variable "node_version" {
  description = "Node.js version"
  type        = string
  default     = "18"
}

variable "cosmos_db_endpoint" {
  description = "Cosmos DB endpoint"
  type        = string
  sensitive   = true
}

variable "cosmos_db_key" {
  description = "Cosmos DB primary key"
  type        = string
  sensitive   = true
}

variable "key_vault_id" {
  description = "Key Vault resource ID"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
