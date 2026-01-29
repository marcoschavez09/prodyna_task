output "id" {
  description = "App Service ID"
  value       = azurerm_linux_web_app.main.id
}

output "name" {
  description = "App Service name"
  value       = azurerm_linux_web_app.main.name
}

output "url" {
  description = "App Service URL"
  value       = "https://${azurerm_linux_web_app.main.default_host_name}"
}

output "staging_slot_id" {
  description = "Staging slot ID (if exists)"
  value       = var.environment != "dev" ? azurerm_linux_web_app_slot.staging[0].id : null
}
