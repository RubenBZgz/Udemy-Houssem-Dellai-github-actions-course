provider "azurerm" {
  features {}
}

terraform {
  cloud {
    organization = "$HCP_ORGANIZATION"

    workspaces {
      name = "$HCP_WORKSPACE"
    }
  }
}

