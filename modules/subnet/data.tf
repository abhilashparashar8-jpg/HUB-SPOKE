data "azurerm_network_security_group" "NSG" {
for_each = var.subnet
  name                = each.value.nsg_name
  resource_group_name = each.value.resource_group_name
}