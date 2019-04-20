variable "resource_group_name" {
  description = "Name of the resource group where the resources will be deployed"
  type        = "string"
}

variable "location" {
  description = "Azure region where resources will be located"
  type        = "string"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = "string"
  default     = ""
}

variable "storage_account_tier" {
  description = "Tier to use for this storage account. Valid values are : 'Standard' and 'Premium'."
  default     = "Standard"
}

variable "registry_name" {
  description = "Name of the container registry."
  type        = "string"
  default     = ""
}

variable "jenkins_vm_dns_prefix" {
  description = "Label for the DNS Name. Will be used to make up the FQDN of the Jenkins VM public IP."
  type        = "string"
}
