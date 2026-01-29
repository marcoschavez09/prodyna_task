variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "spa-app"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "West Europe"
}

variable "infrastructure_version" {
  description = "Infrastructure version (from git tag)"
  type        = string
  default     = "dev"
}

variable "git_commit_sha" {
  description = "Git commit SHA for traceability"
  type        = string
  default     = ""
}

variable "git_tag" {
  description = "Git tag for traceability"
  type        = string
  default     = ""
}

variable "repository_url" {
  description = "Git repository URL"
  type        = string
  default     = "https://github.com/org/infrastructure"
}
