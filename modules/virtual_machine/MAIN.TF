resource "azurerm_linux_virtual_machine" "virtualmachine" {
  for_each                        = var.virtualmachine
  name                            = each.value.virtual_machine_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault.VMusername[each.key].value
  admin_password                  = data.azurerm_key_vault.VMpassword[each.key].value
  disable_password_authentication = true
  network_interface_ids = [
    data.azurerm_network_interface.NIC[each.key].id,
  ]

  os_disk {
    caching              = each.value.caching_name
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-pro-gen1"
    sku       = "24_04-lts"
    version   = "latest"
  }
}
