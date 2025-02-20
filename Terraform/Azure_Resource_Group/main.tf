resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "insecure" {
  name                     = "insecurestorageacct"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # This setting is insecure – secure transfer should be enabled.
  https_traffic_only_enabled = true

  tags = {
    environment = "dev"
  }

  public_network_access_enabled = false
  min_tls_version = var.min_tls_version
  allow_nested_items_to_be_public = false # CKV_AZURE_190
  
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  # CKV2_AZURE_41. This characteristic is enabled by default and should be configured like this:
  shared_access_key_enabled = true
  sas_policy {
    expiration_period = "07.00:00:00"
  }
}


# CKV_AZURE_190. Ensure Storage logging is enabled for Queue service for read, write and delete requests
# queue_properties can only be configured when account_tier is set to Standard and account_kind is set to either Storage or StorageV2
resource "azurerm_storage_account_queue_properties" "example" {
  storage_account_id = azurerm_storage_account.insecure.id
  logging {
    version               = "2.0"
    delete                = true
    read                  = true
    write                 = true
    retention_policy_days = 7
  }

}