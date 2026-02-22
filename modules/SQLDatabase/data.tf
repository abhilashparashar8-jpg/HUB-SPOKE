data "azurerm_mssql_server" "data" {
  for_each = var.sqldatabase
  name                = each.value.sqlserver_name
  resource_group_name = each.value.resource_group_name
}