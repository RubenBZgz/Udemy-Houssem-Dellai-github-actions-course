variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
  default     = ""
}

variable "HCP_ORGANIZATION" {
  type        = string
  description = "HCP Terraform organization"
  default     = ""
}

variable "HCP_WORKSPACE" {
  type        = string
  description = "HCP Terraform workspace"
  default     = ""
}

# RESOURCE VARIABLES
variable "location" {
  type        = string
  description = "Resource location"
  default     = "West Europe"
}

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