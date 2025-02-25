resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type #CKV_AZURE_206. False positive. Only GRS, RAGRS, GZRS, or RAGZRS are supported
  https_traffic_only_enabled    = true

  # Security fixes
  public_network_access_enabled = true # CKV_AZURE_59: "Ensure that Storage accounts disallow public access". If you don't activate this, you cannot create table and queue services. 
  min_tls_version               = var.min_tls_version #CKV_AZURE_44: "Ensure Storage Account is using the latest version of TLS encryption"
  allow_nested_items_to_be_public = true # CKV2_AZURE_47: "Ensure storage account is configured without blob anonymous access"
  # Actually, it's not supported at false. Pipeline explodes

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  # CKV2_AZURE_41. This characteristic is enabled by default and should be configured like this or disabled. If you disable it, pipeline explodes for lack of permissions.
  #shared_access_key_enabled = false
  shared_access_key_enabled = true
  sas_policy {
    expiration_period = "07.00:00:00"
  }
}

# Container for blobs
resource "azurerm_storage_container" "container" {
  name                  = var.storage_account_name
  storage_account_id    = azurerm_storage_account.example.id
  container_access_type = "private" # "container" "blob". Anonymous readd acess for containers and/or blobs or not allowed.
}

/*
resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}
*/



resource "azurerm_storage_share" "example" {
  name               = "sharename"
  storage_account_id = azurerm_storage_account.example.id
  quota              = 50
}

/*
resource "azurerm_storage_share_file" "example" {
  name             = "my-awesome-content.zip"
  storage_share_id = azurerm_storage_share.example.id
  source           = "some-local-file.zip"
}*/

resource "azurerm_storage_queue" "example" {
  name                 = "myqueue"
  storage_account_name = azurerm_storage_account.example.name
}

#If you want to enable azure table, you need to change public_network_access_enabled to true
resource "azurerm_storage_table" "example" {
  name                 = "mysampletable"
  storage_account_name = azurerm_storage_account.example.name
}

# CKV_AZURE_190. Ensure Storage logging is enabled for Queue service for read, write and delete requests
resource "azurerm_storage_account_queue_properties" "example" {
  storage_account_id = azurerm_storage_account.example.id
  /*cors_rule {
    allowed_origins    = ["http://www.example.com"]
    exposed_headers    = ["x-tempo-*"]
    allowed_headers    = ["x-tempo-*"]
    allowed_methods    = ["GET", "PUT"]
    max_age_in_seconds = "500"
  }*/

  logging {
    version               = "1.0"
    delete                = true
    read                  = true
    write                 = true
    retention_policy_days = 7
  }

  hour_metrics {
    version               = "1.0"
    retention_policy_days = 7
  }

  minute_metrics {
    version               = "1.0"
    retention_policy_days = 7
  }
}