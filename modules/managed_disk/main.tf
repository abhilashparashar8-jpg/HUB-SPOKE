resource "azurerm_managed_disk" "Mdisk" {
    for_each = var.Mdisk
  name                 = each.value.managed_disk_name
  location             = each.value.location
  resource_group_name  = each.value.resource_group_name
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb  
}