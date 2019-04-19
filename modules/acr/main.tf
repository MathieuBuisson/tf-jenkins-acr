resource "azurerm_container_registry" "acr" {
  name                = "${var.registry_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  sku                 = "${var.registry_sku}"
  admin_enabled       = "${var.admin_user_enabled}"
  storage_account_id  = "${var.storage_account_id}"
}
