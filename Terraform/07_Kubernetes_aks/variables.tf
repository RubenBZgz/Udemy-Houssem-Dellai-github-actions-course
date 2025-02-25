# GLOBAL
variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
  default     = ""
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
  default     = "West Europe"
}


# RESOURCE VARIABLES
variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default     = "07kubernetesaks"
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
  default     = "07kubernetesaks"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.30.3"
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
  default     = 3
}

variable "node_resource_group" {
  type        = string
  description = "RG name for cluster resources in Azure"
  default     = "07kubernetesaks"
}