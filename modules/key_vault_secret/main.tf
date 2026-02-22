resource "azurerm_key_vault_secret" "kvs123" {
  for_each     = var.kvs123
  name         = each.value.secret_name
  value        = each.value.secret_type
  key_vault_id = data.azurerm_key_vault.key_vault_id[each.key].id
  
}
