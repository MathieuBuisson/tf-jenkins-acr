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
