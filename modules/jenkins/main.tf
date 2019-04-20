resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.vm_name}"
  resource_group_name   = "${var.resource_group_name}"
  location              = "${var.location}"
  network_interface_ids = ["${var.nic_id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "${var.ubuntu_version}"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.vm_name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

data "template_file" "extension_protected_settings" {
  template = "${file("${path.module}/extension-protected-settings.tpl")}"

  vars = {
    public_ip_fqdn           = "${var.public_ip_fqdn}"
    admin_username           = "${var.admin_username}"
    git_repository           = "${var.git_repository}"
    registry_login_server    = "${var.registry_login_server}"
    service_principal_id     = "${var.service_principal_id}"
    service_principal_secret = "${var.service_principal_secret}"
  }
}

resource "azurerm_virtual_machine_extension" "script" {
  name                       = "${var.vm_name}-init"
  resource_group_name        = "${var.resource_group_name}"
  location                   = "${var.location}"
  virtual_machine_name       = "${azurerm_virtual_machine.vm.name}"
  publisher                  = "Microsoft.Azure.Extensions"
  type                       = "CustomScript"
  type_handler_version       = "2.0"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "fileUris": ["https://raw.githubusercontent.com/Azure/azure-devops-utils/v0.30.0/quickstart_template/201-jenkins-acr.sh"]
    }
SETTINGS

  protected_settings = "${data.template_file.extension_protected_settings.rendered}"
}
