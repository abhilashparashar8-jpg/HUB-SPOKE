data "azurerm_mssql_server" "mssql" {
  for_each            = var.ppoint
  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "subnet" {
  for_each             = var.ppoint
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  for_each            = var.ppoint
  name                = each.value.vnet_name
  resource_group_name = each.value.resource_group_name
}

