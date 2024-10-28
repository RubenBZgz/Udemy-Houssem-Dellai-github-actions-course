terraform {

  /*  NORMAL AZURE BACKEND HARDCODED
  backend "azurerm" {
    resource_group_name   = ""
    storage_account_name  = ""
    container_name        = ""
    key                   = ""
  } */

  # Terraform Cloud Backend
  cloud {
    organization = "Udemy-github-actions-course"

    workspaces {
      name = "Udemy-Houssem-Dellai-github-actions-course"
    }
  }
}