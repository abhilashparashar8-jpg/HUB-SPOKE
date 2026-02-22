data "azurerm_subnet" "subnet" {
    for_each = var.loadbalancer
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_network_interface" "network_interface" {
   for_each = var.loadbalancer
  name                = each.value.network_interface_name
  resource_group_name = each.value.resource_group_name
}