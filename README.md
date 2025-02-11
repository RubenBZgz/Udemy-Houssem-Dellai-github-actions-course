# DevOps-Proyect

This is a CI/CD proyect using Terraform and GitHub actions. 
The objective of this proyect is to provide a professional IAC deployment using best practices
and ensuring the security.

DevOps became very imprtant for organiztions willing to automate and modernaze their workloads. Thanks to its capabilities, it is never been easier create a pipeline that can do all the required staps to build 'almost' any kind of application and deploy 'almost' to any environment. All of this with a click of a button.


## Table of Contents
* [Prerequisites](#prerequisites)
  * [Initial Setup](#initial-setup)
  * [GitHub Actions secret variables](#github-secrets)
* [Usage](#usage)
* [Version History](#version-history)
* [Future Features](#future-features)
* [Disclaimer and Warning](#disclaimer-and-warning)
<!-- 
* [Customizing](#customizing)
  * [inputs](#inputs)
  * [Environment variables](#environment-variables)
  * [Trivy config file](#trivy-config-file)
-->

### Prerequisites
Mandatory: 
* Azure subscription. 
* Terraform. Needed in your local machine to make changes correctly.
* GitHub secrets. 

Optional:
* Backend provider. Azure or Teraform Cloud are supported.
* Personal Access Token. 


### Initial Setup
0. Install Azure CLI or update your azure cli version running az upgrade. https://learn.microsoft.com/en-us/cli/azure/install-azure-cli 
1. Create your Azure account. https://azure.microsoft.com/es-es/get-started/azure-portal/
2. Execute the following commands in powershell.
```powershell
az login
az account show # The field named id is the Subscription ID.
$SUBSCRIPTION_ID = "xxxx"
# Create a Service Principal with contributor role for Terraform
az ad sp create-for-rbac -n "Rubenbzgz-github-actions" --role Contributor --scope /subscriptions/$SUBSCRIPTION_ID --sdk-auth
# Create Github Actions secrets and save output values of the Service Principal: secrets.AZURE_CLIENT_ID, secrets.AZURE_CLIENT_SECRET, secrets.AZURE_SUBSCRIPTION_ID, secrets.AZURE_TENANT_ID 
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

3. Save the results of the previous command in GitHub secret variable AZURE_CREDENTIALS like the example below:
```
{
  "clientId": "xxxxxxxx-xxx",
  "clientSecret": "xxxxxxxxx",
  "subscriptionId": "xxxxxxxx-xxx",
  "tenantId": "xxxxxxxx-xxx"
}
```




Optional:
If you want to execute terraform on your local machine, follow the instructions:
1. Install Terraform. https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-cli

Available backends.tf configurations:
- Azure Storage Account backend:
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

- Terraform Cloud backend:
https://developer.hashicorp.com/terraform/language/backend/remote
1. Terraform login
<!-- 
2. cd tfc-getting-started 
3. scripts/setup.sh -->
2. Create terraform backend like this
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

If you have Terraform Cloud, you will to create your PAT.
* Profile -> Settings -> Developer settings -> Personal access token -> Fine-grained tokens -> Generate new token.
![PAT Permissions](/Readme-images/PAT%20permissions.PNG)


#### GitHub Secrets 
Mandatory:
<!-- Comprobar OICD para quitarlo -->
AZURE_CLIENT_ID
<!-- Comprobar OICD para quitarlo -->
AZURE_CLIENT_SECRET
AZURE_CREDENTIALS
AZURE_SUBSCRIPTION_ID
<!-- Comprobar OICD para quitarlo -->
AZURE_TENANT_ID


Optional:
* If you have an Azure Backend:
  - BACKEND_CONTAINER_NAME
  - BACKEND_KEY
  - BACKEND_RESOURCE_GROUP_NAME
  - BACKEND_STORAGE_ACCOUNT_NAME


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




[![Terraform deployment](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/terraform-devops.yml/badge.svg)](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/terraform-devops.yml)

[![Tfsec security](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-tfsec.yml/badge.svg)](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-tfsec.yml)

[![Trivy security](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-trivy.yml/badge.svg)](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-trivy.yml)

[![Rotate HCP Token](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-rotate-terraformHCP-token.yml/badge.svg)](https://github.com/RubenBZgz/Udemy-Houssem-Dellai-github-actions-course/actions/workflows/AA-rotate-terraformHCP-token.yml)


## Usage
Before reading this section, you should have readed the prerequisites section. Ensure that you have all the necessary configuration. If not, go back to the previous section.

The first step you have to do is to disable AA-rotate-terraformCHP-token.yml if you don't have HCP as your backend. 
It's an scheduled workflow, so it will give error as result each time is executed.

Then, you have 2 different types of running the proyect:
1. Making a push or pull request to the main branch. Whenever one of them is done, several GitHub actions will be executed automatically, deploying you IAC to your Azure Subscription.
2. Executing manually GitHub actions workflow form the web browser. All of them have workflow_dispatch added.



## Version History

* 0.1
  * Initial Release


## Future Features
* GitHub actions terraform-devops.yml workflow to login with OIDC. Is better than using the typical login with service principal.
  https://learn.microsoft.com/en-us/entra/workload-id/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azcli#important-considerations-and-restrictions
* GitHub Actions workflow to deploy containers
* Implementation of Trivy or/and Tfsec in the CI/CD
* Link GitHub repository with Azure 
* Check the best practices for editing Github workflows
* Personal Access Token (PAT) improved security. https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
* Artifact.

Optional:
* Creating custom runner to run the pipelines
* Azure bicep


## Disclaimer and Warning

This project is provided “as is”, without warranties of any kind, either expressed or implied. The author doesn't assume any responsability and shall not be responsible for any direct, indirect, incidental, special, exemplary or consequential damages (including, but not limited to, procurement of goods or services; loss of use, data or profits; or business interruption) caused by the use or inability to use the project, even if advised of the possibility of such damages.

The user assumes full responsibility for the use and implementation of this project. It is strongly recommended that the code and configurations be reviewed and fully understood before use in production environments.

In case of questions or concerns, users are encouraged to contact the project author before proceeding with implementation.