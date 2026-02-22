data "azurerm_key_vault" "virtualmachine" {
    for_each = var.virtualmachine
  name                = each.value.kay_valut_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_key_vault_secret" "VMusername" {
    for_each = var.virtualmachine
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.virtualmachine[each.key].id
}
data "azurerm_key_vault_secret" "VMpassword" {
  for_each = var.virtualmachine
  name         = each.value.secret_password
  key_vault_id = data.azurerm_key_vault.virtualmachine[each.key].id
}
data "azurerm_network_interface" "NIC" {
  for_each = var.virtualmachine
  name                =  each.value.nic_name
  resource_group_name = each.value.resource_group_name
}