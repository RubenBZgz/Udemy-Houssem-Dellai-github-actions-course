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

variable "min_tls_version_storage_account" {
  description = "The minimum TLS version for the storage account"
  type        = string
  default     = "TLS1_2"
}

variable "min_tls_version_sql_server" {
  description = "The minimum TLS version for the storage account"
  type        = string
  default     = "1.2"
}

variable "account_replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"
}


# RESOURCE VARIABLES
variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default     = "05websqldatabase"
}

variable "app_service_plan_name" {
  type        = string
  description = "App Service Plan name in Azure"
  default     = "05websqldatabase"
}

variable "app_service_name" {
  type        = string
  description = "App Service name in Azure"
  default     = "05websqldatabase"
}

variable "sql_server_name" {
  type        = string
  description = "SQL Server instance name in Azure"
  default     = "05websqldatabase"
}

variable "sql_database_name" {
  type        = string
  description = "SQL Database name in Azure"
  default     = "05websqldatabase"
}

variable "sql_admin_login" {
  type        = string
  description = "SQL Server login name in Azure"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Server password name in Azure"
}

## Storage Account
variable "storage_account_name" {
  type        = string
  description = "storage_account_name"
  default     = "05websqldatabases"
}