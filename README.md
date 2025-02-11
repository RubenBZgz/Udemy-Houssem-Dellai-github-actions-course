# DevOps-Proyect

This is a CI/CD proyect using Terraform and GitHub actions. 
The objective of this proyect is to provide a professional IAC deployment using best practices
and ensuring the security.


## Description

An in-depth paragraph about your project and overview of use.
This DevOps Proyect is based in the Linkedin Learning Course of DevOps Foundations: Your First Proyect, with the objective of create a functional website development environment in azure. Technologies used:
* Website example.


## Table of Contents
* [Prerequisites](#prerequisites)
  * [Initial Setup](#initial-setup)
  * [GitHub Actions secret variables](#github-secrets)
* [Usage](#usage)
  * [Scan CI Pipeline](#scan-ci-pipeline)
* [Customizing](#customizing)
  * [inputs](#inputs)
  * [Environment variables](#environment-variables)
  * [Trivy config file](#trivy-config-file)


### Prerequisites
Mandatory: 
* Azure subscription. 
* Terraform. Needed in your local machine to make changes correctly.
* GitHub secrets. 
* Personal Access Token. 

Optional:
* Backend provider. Azure or Teraform Cloud are supported.


### Initial Setup
1. Create your Azure account. https://azure.microsoft.com/es-es/get-started/azure-portal/
2. Create your Service Principal.
```bash
## Create a Service Principal with contributor role for Terraform
az ad sp create-for-rbac -n "Rubenbzgz-github-actions" --role Contributor --scope /subscriptions/$SUBSCRIPTION_ID --sdk-auth
## Create Github Actions secrets and save output values of the Service Principal: secrets.AZURE_CLIENT_ID, secrets.AZURE_CLIENT_SECRET, secrets.AZURE_SUBSCRIPTION_ID, secrets.AZURE_TENANT_ID 
---------
output:
---------
{
  "clientId": "xxxxxxxx-xxx",
  "clientSecret": "xxxxxxxxx",
  "subscriptionId": "xxxxxxxx-xxx",
  "tenantId": "xxxxxxxx-xxx",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}
```

3. Install Terraform. https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-cli

4. Personal Access Token. Profile -> Settings -> Developer settings -> Personal access token -> Fine-grained tokens -> Generate new token.
![PAT Permissions](/Readme-images/PAT%20permissions.PNG)


#### GitHub Secrets 
Mandatory:
<!-- Comprobar OICD para quitarlo -->AZURE_CLIENT_ID
<!-- Comprobar OICD para quitarlo -->AZURE_CLIENT_SECRET
AZURE_CREDENTIALS
AZURE_SUBSCRIPTION_ID
<!-- Comprobar OICD para quitarlo -->AZURE_TENANT_ID


Optional:
* If you have an Azure Backend:
  - BACKEND_CONTAINER_NAME
  - BACKEND_KEY
  - BACKEND_RESOURCE_GROUP_NAME
  - BACKEND_STORAGE_ACCOUNT_NAME
```
terraform {
  # Azure Backend
  backend "azurerm" {
    resource_group_name   = "xxxx"
    storage_account_name  = "xxxx"
    container_name        = "xxxx"
    key                   = "xxxx"
  } 
}
```

* If you have Terraform Cloud backend:
  - HCP_ORGANIZATION. Organization name
  - HCP_WORKSPACE. Workspace name
  - PAT_RENEW_SECRET_KEY. PAT Token of GitHub
  - TF_API_TOKEN. Owner team token of Terraform Cloud
```
terraform {
  # Terraform Cloud Backend
  cloud {
    organization = "Your HCP Terraform Organization"

    workspaces {
      name = "Your HCP Terraform Workspace"
    }
  }
}
```


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
  # Terraform Cloud Backend
  cloud {
    organization = "Your HCP Terraform Organization"

    workspaces {
      name = "Your HCP Terraform Workspace"
    }
  }
}
```

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

[![Tfsec security](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-tfsec.yml/badge.svg)](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-tfsec.yml)

[![Trivy security](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-trivy.yml/badge.svg)](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-trivy.yml)

[![Rotate HCP Token](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-rotate-terraformHCP-token.yml/badge.svg)](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-rotate-terraformHCP-token.yml)


## Version History

* 0.1
  * Initial Release


## Disclaimer and Warning

This project is provided “as is”, without warranties of any kind, either expressed or implied. The author doesn't assume any responsability and shall not be responsible for any direct, indirect, incidental, special, exemplary or consequential damages (including, but not limited to, procurement of goods or services; loss of use, data or profits; or business interruption) caused by the use or inability to use the project, even if advised of the possibility of such damages.

The user assumes full responsibility for the use and implementation of this project. It is strongly recommended that the code and configurations be reviewed and fully understood before use in production environments.

In case of questions or concerns, users are encouraged to contact the project author before proceeding with implementation.