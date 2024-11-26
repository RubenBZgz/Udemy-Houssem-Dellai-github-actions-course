/*provider "azurerm" {
  features {}
}

terraform {
  cloud {
    organization = "$HCP_ORGANIZATION"

    workspaces {
      name = "$HCP_WORKSPACE"
    }
  }
}*/


provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.6.0"
    }
  }
}