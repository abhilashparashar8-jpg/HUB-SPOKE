resource "azurerm_network_security_group" "NSG" {
    for_each = var.NSG
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}
 resource "azurerm_network_security_rule" "allow_appgw_v2_infra" {
  for_each = var.NSG
  name                        = each.value.Infra_name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range 
  destination_port_ranges     = each.value.destination_port_ranges
  source_address_prefix       = each.value.source_address_prefix   
  destination_address_prefix  = each.value.destination_address_prefix

  resource_group_name         = each.value.resource_group_name 
  network_security_group_name = azurerm_network_security_group.NSG[each.key].name
} 
