# AA-run-trivy.yml and AA-tfsec.yml
This tools are used to analyze the security of your code.
- Code scanning needs to be allowed.
- Personal Access Token permissions:
    - Code scanning alerts
    - Repository security advisories

# azure-container-apps-ci-cd
Prerequisites:
  - terraform-devops.yml RUNNING. We need the resources to be created
  - Secrets:
    - AZURE_CREDENTIALS. az ad sp create-for-rbac -n "spn-aca-github" --role Contributor --scope /subscriptions/$SUBSCRIPTION_ID --sdk-auth

# terraform-devops.yml
This is the main workflow in order to deploying IAC in azure via terraform using CI/CD.
There is room for improvement as I have not yet implemented artifacts feature.

Future features:
- AWS support.
- Artifact deployment and analysis.
- Implementation of Trivy or Tfsec. Security must be implemented before using this in production.

Prerequites:
- Azure Account
- Create a Service Principal

Optional requisites:
- Backend: 
  - Azure Storage Account. Secrets used:
    - BACKEND_STORAGE_ACCOUNT_NAME
    - BACKEND_RESOURCE_GROUP_NAME
    - BACKEND_CONTAINER_NAME
    - BACKEND_KEY
  - HCP. Secrets used:
    - PAT_RENEW_SECRET_KEY. Settings > Developer Settings > Personal accesss tokens > Fine-grained tokens > Your API Token from Terraform Cloud.
    - TF_API_TOKEN. API Token from owners team in Terraform Cloud project. Check AA-rotate-terraformHCP-token Github Actions Workflow.
    - HCP_ORGANIZATION
    - HCP_WORKSPACE


```bash
## Create a Service Principal with contributor role for Terraform
az ad sp create-for-rbac --name any-name --role contributor --scopes /subscriptions/<SUBSCRIPTION_ID> --sdk-auth
## Create Github Actions secrets and save output values of the Service Principal: secrets.AZURE_CLIENT_ID, secrets.AZURE_CLIENT_SECRET, secrets.AZURE_SUBSCRIPTION_ID, secrets.AZURE_TENANT_ID 
---------
output:
---------
{
  "clientId": "227271a6-xxx",
  "clientSecret": "Aw8l8Rxxx",
  "subscriptionId": "17b12858-xxx",
  "tenantId": "558506eb-xxx",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}

## Assing Contributor role in order to manage resources.
#az role assignment create --assignee <service-principal-id> --role Contributor --scope /subscriptions/
```

More resources:  
https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions?tabs=CLI

If you want to deploy an Azure Kubernetes Service (AKS), you have to check this repository:
https://github.com/HoussemDellai/ProductsStoreOnKubernetes
https://github.com/HoussemDellai/aks-course

In order to deploy an Azure Container Apps, check this repo:
https://github.com/HoussemDellai/aca-course
https://github.com/HoussemDellai/aca-landing-zone-accelerator
https://github.com/HoussemDellai/aca-vs-aks