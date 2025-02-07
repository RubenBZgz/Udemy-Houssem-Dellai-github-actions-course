Secrets:
BACKEND_ORGANIZATION = Organization name of your HCP Terraform organization
TF_API_TOKEN = API token to login inside my HCP Terraform workspace teams and lauch terraform init, apply...
GITHUB_PAT = Fine-grained personal access token to update secrets of the repository
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens


Requirements:
az -upgrade

I have used HCP Terraform (Terraform Cloud service) in order to have secure access to my secret keys of my Azure Backend. 
https://developer.hashicorp.com/terraform/language/backend/remote
1. Terraform login
2. cd tfc-getting-started
3. scripts/setup.sh
4. Create terraform backend like this
```
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
    organization = "Your HCP Terraform Organization"

    workspaces {
      name = "Your HCP Terraform Workspace"
    }
  }
}
```


In my case, I'm going to use a variable set to use this credentials across multiple proyects. You can create it in your workspace settings.

If you don't want to use this, you can use other alternatives like variables or backend.tf


# Github Actions course

DevOps became very imprtant for organiztions willing to automate and modernaze their workloads. Thanks to its capabilities, it is never been easier create a pipelin that can do all the required staps to build 'almost' any kind of application and deploy 'almost' to any environment. All of this with a click of a button.

Not only that, using DevOps features makes it possible to secure the pipelines when managing secrets or when connecting to the target production environment. That become today what is known as DevSecOps.

Many known tools are available to inplement DevOps like Jenkins, Gitlab CI, Azure DevOps Pipelines and many more. Github Actions is one of these tools. It did become popular from the first day it was launched back in 2018. That success was due to the popularity of Github as a platform to host the source code used by more than 50 million users. It was very natural to use the same platform to build and deploy that code into production.

This course will walk you through the creation of CI/CD DevOps pipelines to take your code, build it, scan it, test it then deploy it into Dev, Test and Prod environments whether that is in premise or on the cloud.

Using multiple demonstrations, we will show the powerful features of Github Actions.

What you’ll learn:
- The fundamentals for writing CI/CD pipelines with Github Actions
- Best practices for editing Github workflows
- Triggering a workflow on a Pull Request, Tag, Push or on a schedule
- Creating DevOps pipelines for Web Apps, Container apps and Databases
- Deploying apps and infra into Azure Cloud
- Using Terraform and Bicep (Infra as Code) with Github Actions
- Creating custom runner to run the pipelines
- Implement DevSecOps principles
- Creating pipelines for aspnet and dockerized apps

Are there any course requirements or prerequisites?
- No DevOps experience required, this course will take you from the ground up to the expert level
- Basic knowledge of Git and Github

Who this course is for:
- All beginners (developers, ops and devops) who wants to learn Github Actions
- Developers who already use Git and Github and are looking to master another cool feature of Github
- DevOps beginners looking for step by step guide to create their first successful CI/CD pipelines
- Ops experts looking for to use Github to automate the deployment of their infrastructure

Samples for Github Actions DevOps pipelines and workflows.

[![Terraform deployment](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/terraform-devops.yml/badge.svg)](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/terraform-devops.yml)

[![020-manual-workflow](https://github.com/HoussemDellai/github-actions-course/actions/workflows/020-manual-input-workflow.yml/badge.svg)](https://github.com/HoussemDellai/github-actions-course/actions/workflows/020-manual-input-workflow.yml)

[![030-dotnet-workflow](https://github.com/HoussemDellai/github-actions-course/actions/workflows/030-dotnet-workflow.yml/badge.svg)](https://github.com/HoussemDellai/github-actions-course/actions/workflows/030-dotnet-workflow.yml)

[![031-build-deploy-webapp-to-azure](https://github.com/HoussemDellai/github-actions-course/actions/workflows/031-build-deploy-webapp-to-azure.yml/badge.svg)](https://github.com/HoussemDellai/github-actions-course/actions/workflows/031-build-deploy-webapp-to-azure.yml)

[![040-github-linter](https://github.com/HoussemDellai/github-actions-course/actions/workflows/040-github-linter.yml/badge.svg)](https://github.com/HoussemDellai/github-actions-course/actions/workflows/040-github-linter.yml)

[![050-docker-build-workflow](https://github.com/HoussemDellai/github-actions-course/actions/workflows/050-docker-build-workflow.yml/badge.svg)](https://github.com/HoussemDellai/github-actions-course/actions/workflows/050-docker-build-workflow.yml)

[![052-docker-ghcr-workflow](https://github.com/HoussemDellai/github-actions-course/actions/workflows/052-docker-ghcr-workflow.yml/badge.svg)](https://github.com/HoussemDellai/github-actions-course/actions/workflows/052-docker-ghcr-workflow.yml)
