resource "azurerm_log_analytics_workspace" "logs" {
    for_each = var.logs
  name                = each.value.log_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  retention_in_days   = each.value.retention_in_days
}