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
  default     = "rg-containerapps-github-actions"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Resource location"
  default     = "workspace-rgcontainerappsgithubactionsPt"
}

variable "container_app_environment_name" {
  type        = string
  description = "Resource location"
  default     = "aca-environment"
}

variable "container_app_name" {
  type        = string
  description = "Resource location"
  default     = "album-backend-api"
}