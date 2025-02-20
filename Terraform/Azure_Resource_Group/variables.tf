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


# RESOURCE VARIABLES
variable "resource_group_name" {
  type        = string
  description = "resource_group_name"
  default     = "rg-containerapps-github-actions-2"
}

