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


# RESOURCE VARIABLES
variable "resource_group_name" {
  type        = string
  description = "resource_group_name"
  default     = "06containerapps"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Resource location"
  default     = "06containerapps"
}

variable "container_app_environment_name" {
  type        = string
  description = "Resource location"
  default     = "containerapps"
}

variable "container_app_name" {
  type        = string
  description = "Resource location"
  default     = "containerapps"
}