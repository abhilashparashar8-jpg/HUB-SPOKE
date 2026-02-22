resource "azurerm_private_endpoint" "ppoint" {
  for_each            = var.ppoint
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = data.azurerm_subnet.subnet[each.key].id

  private_service_connection {
    name                           = each.value.privateserviceconnection_name
    private_connection_resource_id = data.azurerm_mssql_server.mssql[each.key].id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = each.value.is_manual_connection
  }

  private_dns_zone_group {
    name                 = each.value.dns-zone-group_name
    private_dns_zone_ids = [azurerm_private_dns_zone.dnszone[each.key].id]
  }
}

resource "azurerm_private_dns_zone" "dnszone" {
  for_each = var.ppoint

  name                = each.value.privatelink_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dzvnl" {
  for_each              = var.ppoint
  name                  = each.value.link_name
  resource_group_name   = each.value.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dnszone[each.key].name
  virtual_network_id    = data.azurerm_virtual_network.vnet[each.key].id
}
