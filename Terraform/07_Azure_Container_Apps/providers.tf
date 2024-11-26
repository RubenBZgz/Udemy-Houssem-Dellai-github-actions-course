terraform {
  cloud {
    organization = "$HCP_ORGANIZATION"

    workspaces {
      name = "$HCP_WORKSPACE"
    }
    #token = "$TF_TOKEN_app_terraform_io"

  }
}
