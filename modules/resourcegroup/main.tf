resource "azurerm_resource_group" "RG1" {
  for_each = var.RG1
  name     = each.value.name
  location = each.value.location
}