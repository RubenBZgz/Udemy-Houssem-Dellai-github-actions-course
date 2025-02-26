resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type #CKV_AZURE_206. False positive. Only GRS, RAGRS, GZRS, or RAGZRS are supported
  https_traffic_only_enabled    = true
  min_tls_version               = var.min_tls_version_storage_account 

  # Security fixes
  # When public_network_access_enabled is false, you cannot access the resource with the service principal, so
  public_network_access_enabled = true # CKV_AZURE_59: "Ensure that Storage accounts disallow public access". If you don't activate this, you cannot create table and queue services. 
  allow_nested_items_to_be_public = false # CKV_AZURE_190: "Ensure that Storage blobs restrict public access"

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