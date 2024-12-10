output "container_app_details" {
  value = {

    name                = azurerm_container_app.example.name
    resource_group_name = azurerm_container_app.example.resource_group_name
    ingress_target_port = azurerm_container_app.example.ingress[0].target_port
    external_enabled    = azurerm_container_app.example.ingress[0].external_enabled
    image               = azurerm_container_app.example.template[0].container[0].image
    cpu                 = azurerm_container_app.example.template[0].container[0].cpu
    memory              = azurerm_container_app.example.template[0].container[0].memory
    fqdn                = azurerm_container_app.example.ingress[0].fqdn
  }
}
