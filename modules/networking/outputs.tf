output "nic_id" {
  value = "${azurerm_network_interface.nic.id}"
}

output "public_ip_fqdn" {
  value = "${azurerm_public_ip.ip.fqdn}"
}
