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