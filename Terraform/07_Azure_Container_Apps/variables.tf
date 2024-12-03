variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "HCP_ORGANIZATION" {
  type        = string
  description = "HCP Terraform organization"
}

variable "HCP_WORKSPACE" {
  type        = string
  description = "HCP Terraform workspace"
}