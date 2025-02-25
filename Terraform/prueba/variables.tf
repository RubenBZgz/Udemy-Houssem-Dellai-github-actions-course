# GLOBAL
variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
  default     = ""
}

variable "location" {
  type        = string
  description = "Resource location"
  default     = "West Europe"
}

variable "min_tls_version" {
  description = "The minimum TLS version for the storage account"
  type        = string
  default     = "TLS1_2"
}

variable "account_replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"
}


# RESOURCE VARIABLES
variable "resource_group_name" {
  type        = string
  description = "resource_group_name"
  default     = "pruebademorg"
}

variable "storage_account_name" {
  type        = string
  description = "storage_account_name"
  default     = "pruebaaccstg"
}
