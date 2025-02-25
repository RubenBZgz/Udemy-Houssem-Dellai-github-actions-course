resource "azurerm_log_analytics_workspace" "example" {
  name                = "acctest-01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}


resource "azurerm_log_analytics_storage_insights" "blobExample_ok" {
  name                = "example-storageinsightconfig"
  resource_group_name = azurerm_resource_group.example.name
  workspace_id        = azurerm_log_analytics_workspace.example.id

  storage_account_id  = azurerm_storage_account.example.id
  storage_account_key = azurerm_storage_account.example.primary_access_key

  # CKV2_AZURE_20: "Ensure Storage logging is enabled for Table service for read requests"
  #table_names = [azurerm_storage_table.example.name]

  # CKV2_AZURE_21: "Ensure Storage logging is enabled for Blob service for read requests"
  blob_container_names = [azurerm_storage_container.container.name]
}