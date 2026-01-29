# App Service Module - Node.js Backend

resource "azurerm_service_plan" "main" {
  name                = "asp-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  
  os_type  = "Linux"
  sku_name = var.app_service_plan_sku
  
  tags = var.tags
}

resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.main.id
  
  site_config {
    application_stack {
      node_version = var.node_version
    }
    
    always_on = var.environment == "prod" ? true : false
  }
  
  app_settings = {
    "NODE_ENV"                    = var.environment
    "COSMOS_DB_ENDPOINT"          = var.cosmos_db_endpoint
    "COSMOS_DB_KEY"               = var.cosmos_db_key
    "KEY_VAULT_URI"               = var.key_vault_id
    "WEBSITE_NODE_DEFAULT_VERSION" = var.node_version
    "INFRASTRUCTURE_VERSION"      = var.tags["Version"]
    "GIT_COMMIT_SHA"              = var.tags["GitCommit"]
  }
  
  identity {
    type = "SystemAssigned"
  }
  
  tags = var.tags
}

# Deployment slot for staging (only in test/prod)
resource "azurerm_linux_web_app_slot" "staging" {
  count = var.environment != "dev" ? 1 : 0
  
  name           = "staging"
  app_service_id = azurerm_linux_web_app.main.id
  
  site_config {
    application_stack {
      node_version = var.node_version
    }
    
    always_on = true
  }
  
  app_settings = azurerm_linux_web_app.main.app_settings
  
  identity {
    type = "SystemAssigned"
  }
  
  tags = var.tags
}
