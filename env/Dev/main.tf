module "resourcegroup" {
  source = "../../modules/resourcegroup"
  RG1    = var.RG1
}
module "storageaccount" {
  depends_on = [module.resourcegroup]
  source     = "../../modules/storageaccount"
  STG        = var.STG
}
module "vnet" {
  depends_on = [module.resourcegroup]
  source     = "../../modules/vnet"
  vnet       = var.vnet
}
module "subnet" {
  depends_on = [module.vnet, module.NSG, module.resourcegroup ]
  source     = "../../modules/subnet"
  subnet    = var.subnet
}
module "PUBIP" {
  depends_on = [module.resourcegroup]
  source     = "../../modules/Public IP"
  PUBIP      = var.PUBIP
}
module "NSG" {
  depends_on = [module.resourcegroup]
  source     = "../../modules/NSG"
  NSG        = var.NSG
}
module "NIC" {
  depends_on = [module.resourcegroup, module.subnet]
  source     = "../../modules/NIC"
  NIC        = var.NIC
}
module "SQLserver" {
  depends_on = [module.resourcegroup, module.subnet]
  source     = "../../modules/SQLserver"
  mssql      = var.mssql
}
module "sqldatabase" {
  depends_on  = [module.resourcegroup, module.subnet, module.SQLserver]
  source      = "../../modules/sqldatabase"
  sqldatabase = var.sqldatabase
}
module "ppoint" {
  depends_on = [module.resourcegroup, module.subnet, module.SQLserver]
  source     = "../../modules/private_end_point"
  ppoint     = var.ppoint
}
module "networkinterface" {
  depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet]
  source           = "../../modules/network_interface"
  networkinterface = var.networkinterface
}
module "keyvault" {
  depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet]
  source           = "../../modules/key_vault"
  keyvault = var.keyvault
}
module "kvs" {
  depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet,module.keyvault,module.virtual_machine]
  source           = "../../modules/key_vault_secret"
  kvs123 = var.kvs123
}
module "virtual_machine" {
   depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet,module.keyvault, module.kvs, module.NIC, module.NSG]
  source           = "../../modules/virtual_machine"
  virtualmachine = var.virtualmachine
}
module "managed_disk" {
   depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet,module.keyvault, module.NIC, module.NSG]
  source           = "../../modules/managed_disk"
  Mdisk = var.Mdisk
}
module "loadbalancer" {
   depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet,module.keyvault, module.NIC, module.NSG]
  source           = "../../modules/load_balancer"
  loadbalancer = var.loadbalancer
}
module "application_gateway" {
   depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet,module.keyvault, module.NIC, module.NSG]
  source           = "../../modules/application_gateway"
  networkgateway = var.networkgateway
}
module "vnetpeering" {
   depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet,module.keyvault, module.NIC, module.NSG]
  source           = "../../modules/vnet_peering"
  vnetpeering = var.vnetpeering
}
module "logs" {
   depends_on       = [module.resourcegroup, module.subnet, module.SQLserver, module.vnet,module.keyvault, module.NIC, module.NSG]
  source           = "../../modules/log_analytics_workspace"
  logs = var.logs
}