variable "vm_name" {
  description = "Name of the virtual machine"
  type        = "string"
}

variable "resource_group_name" {
  description = "Name of the resource group where the virtual machine belongs"
  type        = "string"
}

variable "location" {
  description = "Azure region where the virtual machine will be located"
  type        = "string"
}

variable "nic_id" {
  description = "ID of the network interface to attach to the virtual machine"
  type        = "string"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = "string"
}

variable "ubuntu_version" {
  description = "Version of the Ubuntu Server image used for the VM"
  default     = "16.04-LTS"
}

variable "admin_username" {
  description = "Name of the local administrator account"
  type        = "string"
}

variable "admin_password" {
  description = "Password for the local administrator account"
  type        = "string"
}

variable "public_ip_fqdn" {
  description = "Full DNS name associated with the VM's public IP address"
  type        = "string"
}

variable "git_repository" {
  description = "URL to a public git repository that includes a Dockerfile"
  type        = "string"
}

variable "registry_login_server" {
  description = "URL to specify to login to the container registry"
  type        = "string"
}

variable "service_principal_id" {
  description = "Service Principal ID used by Jenkins to access Azure resources (for example, the container registry)"
  type        = "string"
}

variable "service_principal_secret" {
  description = "Service Principal secret used by Jenkins to access Azure resources (for example, the container registry)"
  type        = "string"
}
