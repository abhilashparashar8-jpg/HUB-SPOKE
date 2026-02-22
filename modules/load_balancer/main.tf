resource "azurerm_lb" "loadbalancer" {
  for_each            = var.loadbalancer
  name                = each.value.loadbalancer_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  frontend_ip_configuration {
    name                          = each.value.frontend_ip_name
    private_ip_address            = each.value.private_ip_address
    private_ip_address_allocation = each.value.private_ip_address_allocation
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
  }
}
resource "azurerm_lb_backend_address_pool" "backend_ip" {
  for_each        = var.loadbalancer
  loadbalancer_id = azurerm_lb.loadbalancer[each.key].id
  name            = each.value.backend_ip_name
}
resource "azurerm_lb_rule" "lbrule" {
  for_each                       = var.loadbalancer
  loadbalancer_id                = azurerm_lb.loadbalancer[each.key].id
  name                           = each.value.lb_rule_name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_ip[each.key].id]
}
resource "azurerm_network_interface_backend_address_pool_association" "nicassociation" {
  for_each        = var.loadbalancer
  network_interface_id    = data.azurerm_network_interface.network_interface[each.key].id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_ip[each.key].id
}
resource "azurerm_lb_probe" "halhtprobe" {
  for_each = var.loadbalancer
  loadbalancer_id = azurerm_lb.loadbalancer[each.key].id
  name            = each.value.halth_probe_name 
  port            = each.value.port
}
