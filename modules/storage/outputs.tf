output "storage_account_name" {
  value = "${azurerm_storage_account.sa.name}"
}

output "storage_account_access_key" {
  value = "${azurerm_storage_account.sa.primary_access_key}"
}
