variable "registry_name" {
  description = "Name of the container registry."
  type        = "string"
}

variable "resource_group_name" {
  description = "Name of the resource group where the container registry belongs"
  type        = "string"
}

variable "location" {
  description = "Azure region where the container registry will be located"
  type        = "string"
}

variable "registry_sku" {
  description = "SKU name of the container registry. Valid values are : 'Basic', 'Standard' and 'Premium'."
  default     = "Basic"
}

variable "admin_user_enabled" {
  description = " Whether the admin user should be enabled."
  default     = false
}

variable "storage_account_id" {
  description = "ID of a Storage Account which must be located in the same Azure Region as the registry."
  type        = "string"
}
