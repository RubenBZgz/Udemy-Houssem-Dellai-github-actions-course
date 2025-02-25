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
  type    = string
  default = "22environments"
}