resource "azurerm_public_ip" "ip" {
  name                = "${var.public_ip_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  allocation_method   = "${var.ip_allocation_method}"
  domain_name_label   = "${var.public_ip_dns_label}"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsg_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "ssh-rule"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
  description                 = "Allow SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
}

resource "azurerm_network_security_rule" "http" {
  name                        = "http-rule"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
  description                 = "Allow HTTP"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                      = "${var.subnet_name}"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "${cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, 1)}"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"
  depends_on                = ["azurerm_network_security_rule.ssh", "azurerm_network_security_rule.http"]
}

resource "azurerm_subnet_network_security_group_association" "nsglink" {
  subnet_id                 = "${azurerm_subnet.subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"
}
