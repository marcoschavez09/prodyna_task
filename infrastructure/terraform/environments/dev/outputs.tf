output "resource_group_name" {
  description = "Resource group name"
  value       = module.resource_group.name
}

output "static_web_app_url" {
  description = "Static Web App URL"
  value       = module.static_web_app.url
}

output "app_service_url" {
  description = "App Service URL"
  value       = module.app_service.url
}

output "cosmos_db_endpoint" {
  description = "Cosmos DB endpoint"
  value       = module.cosmos_db.endpoint
  sensitive   = true
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = module.key_vault.uri
}

output "infrastructure_version" {
  description = "Deployed infrastructure version"
  value       = var.infrastructure_version
}

output "git_commit_sha" {
  description = "Git commit SHA"
  value       = var.git_commit_sha
}

output "git_tag" {
  description = "Git tag"
  value       = var.git_tag
}
