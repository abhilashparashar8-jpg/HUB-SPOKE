resource "azurerm_application_gateway" "networkgateway" {
    for_each = var.networkgateway
  name                = each.value.network_gatway_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = each.value.sku_name
    tier     = each.value.tier
    capacity = each.value.capacity
  }

  gateway_ip_configuration {
    name      = each.value.gateway_ip_configuration_name
    subnet_id = data.azurerm_subnet.subnet[each.key].id
  }

  frontend_port {
    name = each.value.frontend_port_name
    port = each.value.port
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.PUBIP[each.key].id
  }

  backend_address_pool {
    name = each.value.backend_address_pool_name
  }

  backend_http_settings {
    name                  = each.value.http_setting_name
    cookie_based_affinity = each.value.cookie_based_affinity
    path                  = each.value.path
    port                  = each.value.port
    protocol              = each.value.protocol
    request_timeout       = each.value.request_timeout
  }

  http_listener {
    name                           = each.value.listener_name
    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name             = each.value.frontend_port_name
    protocol                       = each.value.protocol
  }
     
  request_routing_rule {
    name                       = each.value.request_routing_rule_name
    priority                   = each.value.priority 
    rule_type                  = each.value.rule_type 
    http_listener_name         = each.value.listener_name
    backend_address_pool_name  = each.value.backend_address_pool_name
    backend_http_settings_name = each.value.http_setting_name
  }
}