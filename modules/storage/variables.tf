variable "storage_account_name" {
  description = "Name of the storage account"
  type        = "string"
}

variable "resource_group_name" {
  description = "Name of the resource group where the storage account belongs"
  type        = "string"
}

variable "location" {
  description = "Azure region where the storage account will be located"
  type        = "string"
}

variable "storage_account_tier" {
  description = "Tier to use for this storage account. Valid values are : 'Standard' and 'Premium'."
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Type of replication to use for this storage account. Valid values are : 'LRS', 'GRS', 'RAGRS' and 'ZRS'."
  default     = "LRS"
}

variable "storage_account_kind" {
  description = "Kind of storage account. Valid values are : 'Storage', 'StorageV2' and 'BlobStorage'."
  default     = "Storage"
}

variable "blob_encryption" {
  description = "Whether Encryption Services should be enabled for Blob storage"
  default     = true
}

variable "file_encryption" {
  description = "Whether Encryption Services should be enabled for file storage"
  default     = false
}

variable "encryption_key_source" {
  description = "Encryption key source for the storage account. Valid values are : 'Microsoft.Keyvault' and 'Microsoft.Storage'."
  default     = "Microsoft.Storage"
}
