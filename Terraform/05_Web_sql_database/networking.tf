resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "endpoint" {
  name                 = "endpoint"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.endpoint.id
  network_security_group_id = azurerm_network_security_group.example.id
}

# CKV2_AZURE_33: "Ensure storage account is configured with private endpoint"
resource "azurerm_private_endpoint" "blob" {
  name                = "prueba-blob-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.example.id
    is_manual_connection           = false
    # Some resource types (such as Storage Account) only support 1 subresource per private endpoint.
    subresource_names             = ["blob","mysqlServer","sqlServer"]   # This is required!
    #subresource_names             = ["blob","table","queue","file","web","dfs"]   # Available values
  }
}

/*
resource "azurerm_private_endpoint" "queue" {
  name                = "queue-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.example.id
    is_manual_connection           = false
    subresource_names             = ["queue","blob"]   # This is required!
    #subresource_names             = ["blob","table","queue","file","web","dfs"]   # This is required!
  }
}*/
/*
resource "azurerm_private_endpoint" "table" {
  name                = "table-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.example.id
    is_manual_connection           = false
    subresource_names             = ["table"]   # This is required!
    #subresource_names             = ["blob","table","queue","file","web","dfs"]   # This is required!
  }
}*/
/*
resource "azurerm_private_endpoint" "file" {
  name                = "file-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "example-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.example.id
    is_manual_connection           = false
    subresource_names             = ["file"]   # This is required!
    #subresource_names             = ["blob","table","queue","file","web","dfs"]   # This is required!
  }
}*/