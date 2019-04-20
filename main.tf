resource "random_string" "suffix" {
  length  = 10
  upper   = false
  special = false
}

locals {
  resource_prefix              = "jenkins"
  resource_suffix              = "${random_string.suffix.result}"
  default_storage_account_name = "registry${local.resource_suffix}"
  storage_account_name         = "${var.storage_account_name != "" ? var.storage_account_name : local.default_storage_account_name}"
  default_acr_name             = "acr${local.resource_suffix}"
  acr_name                     = "${var.registry_name != "" ? var.registry_name : local.default_acr_name}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

module "storage" {
  source               = "./modules/storage"
  storage_account_name = "${local.storage_account_name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  location             = "${azurerm_resource_group.rg.location}"
  storage_account_tier = "${var.storage_account_tier}"
}

module "acr" {
  source              = "./modules/acr"
  registry_name       = "${local.acr_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  storage_account_id  = "${module.storage.storage_account_id}"
}

module "networking" {
  source              = "./modules/networking"
  public_ip_name      = "${local.resource_prefix}-publicip"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  public_ip_dns_label = "${var.jenkins_vm_dns_prefix}"
  nsg_name            = "${local.resource_prefix}-nsg"
  vnet_name           = "${local.resource_prefix}-vnet"
  subnet_name         = "${local.resource_prefix}-subnet"
  nic_name            = "${local.resource_prefix}-nic"
}

module "jenkins" {
  source                   = "./modules/jenkins"
  vm_name                  = "${var.jenkins_vm_dns_prefix}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  nic_id                   = "${module.networking.nic_id}"
  vm_size                  = "${var.vm_size}"
  admin_username           = "${var.admin_username}"
  admin_password           = "${var.admin_password}"
  public_ip_fqdn           = "${module.networking.public_ip_fqdn}"
  git_repository           = "${var.git_repository}"
  registry_login_server    = "${module.acr.login_server}"
  service_principal_id     = "${var.service_principal_id}"
  service_principal_secret = "${var.service_principal_secret}"
}
