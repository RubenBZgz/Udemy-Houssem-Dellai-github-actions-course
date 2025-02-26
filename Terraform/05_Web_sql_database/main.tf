resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = "B1" #CKV_AZURE_225: "Ensure the App Service Plan is zone redundant"# Ensure you're using a production-suitable SKU like Standard or PremiumV3. "P1v3"
  os_type             = "Linux"

  # Security fixes
  worker_count = 2  # CKV_AZURE_212: "Ensure App Service has a minimum number of instances for failover"
  zone_balancing_enabled = true # CKV_AZURE_225: "Ensure the App Service Plan is zone redundant"
  

}

resource "azurerm_linux_web_app" "app" {
  name                = "mywebapp-01357"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.plan.location
  service_plan_id     = azurerm_service_plan.plan.id
  

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    # CKV_AZURE_78: "Ensure FTP deployments are disabled"
    ftps_state = Disabled # The State of FTP / FTPS service. Possible values include AllAllowed, FtpsOnly, and Disabled
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=tcp:azurerm_mssql_server.sql.fully_qualified_domain_name Database=azurerm_mssql_database.db.name;User ID=azurerm_mssql_server.sql.administrator_login;Password=azurerm_mssql_server.sql.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  }

  # Security fixes
    logs {
               detailed_error_messages = true
               failed_request_tracing = true

               # CKV_AZURE_65: "Ensure that App service enables detailed error messages"
               /*
                http_logs {
                    # azure_blob_storage
                    
                    azure_blob_storage {
                      retention_in_days = 7
                      sas_url = azurerm_storage_container.container.sas_url
                    }
                    #file_system
                }*/
            }
  
}

resource "azurerm_mssql_server" "sql" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password

  # Security fixes
  minimum_tls_version           = var.min_tls_version_sql_server # CKV_AZURE_52: "Ensure MSSQL is using the latest version of TLS encryption"
  # CKV2_AZURE_27: "Ensure Azure AD authentication is enabled for Azure SQL (MSSQL)"
  azuread_administrator {
   login_username = "example_admin"
   object_id      = "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
   tenant_id      = "xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
 }

  public_network_access_enabled = false

}

# Check: CKV_AZURE_24: "Ensure that 'Auditing' Retention is 'greater than 90 days' for SQL servers"
resource "azurerm_mssql_server_extended_auditing_policy" "example" {
  server_id                               = azurerm_mssql_server.sql.id
  storage_endpoint                        = azurerm_storage_account.example.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.example.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 120 #CKV_AZURE_24: "Ensure that 'Auditing' Retention is 'greater than 90 days' for SQL servers"

  # Security fixes
  #enable_builtin_logging     = true
  log_monitoring_enabled     = true #CKV_AZURE_156
}

resource "azurerm_mssql_database" "db" {
  name           = "ProductsDB"
  server_id      = azurerm_mssql_server.sql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "S0"

  # Security Fixes
  zone_redundant = true # CKV_AZURE_229
  ledger_enabled = true # CKV_AZURE_224: "Ensure that the Ledger feature is enabled on database that requires cryptographic proof and nonrepudiation of data integrity"
}

/*
#Check: CKV_AZURE_23: "Ensure that 'Auditing' is set to 'On' for SQL servers"
resource "azurerm_mssql_database_extended_auditing_policy" "policy" {
  database_id                             = azurerm_mssql_database.db.id
  storage_endpoint                        = azurerm_storage_account.example.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.example.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 90  #CKV_AZURE_24: "Ensure that 'Auditing' Retention is 'greater than 90 days' for SQL servers"

  # Security fixes
  #enable_builtin_logging     = true
  log_monitoring_enabled     = true #CKV_AZURE_156
}*/




# CKV2_AZURE_2: "Ensure that Vulnerability Assessment (VA) is enabled on a SQL server by setting a Storage Account"
resource "azurerm_mssql_server_security_alert_policy" "example" {
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mssql_server.sql.name
  state               = "Enabled"

  # Security Fixes
  email_account_admins       = true # CKV_AZURE_27: "Ensure that 'Email service and co-administrators' is 'Enabled' for MSSQL servers"
  email_addresses = ["example@gmail.com"] # CKV_AZURE_26: "Ensure that 'Send Alerts To' is enabled for MSSQL servers"
}

resource "azurerm_mssql_server_vulnerability_assessment" "example" {
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.example.id
  storage_container_path          = "${azurerm_storage_account.example.primary_blob_endpoint}${azurerm_storage_container.example.name}/"
  storage_account_access_key      = azurerm_storage_account.example.primary_access_key

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails = [
      "email@example1.com",
      "email@example2.com"
    ]
  }
}