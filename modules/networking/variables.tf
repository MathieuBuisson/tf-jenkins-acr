variable "public_ip_name" {
  description = "Name of the public IP resource"
}

variable "resource_group_name" {
  description = "Name of the resource group where the public IP resource belongs"
  type        = "string"
}

variable "location" {
  description = "Azure region where the public IP resource will be located"
  type        = "string"
}

variable "public_ip_allocation_method" {
  description = "Allocation method for public IP address. Valid values are : 'Static' or 'Dynamic'."
  type        = "string"
  default     = "Dynamic"
}

variable "public_ip_dns_label" {
  description = "Label for the DNS Name. Will be used to make up the FQDN of the public IP."
  type        = "string"
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = "string"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = "string"
}

variable "subnet_name" {
  description = "Name of the virtual network subnet"
  type        = "string"
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = "string"
}
