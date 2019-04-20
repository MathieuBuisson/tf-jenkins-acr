This **Terraform** module deploys a virtual machine running Ubuntu Server.  

It also runs a script extension to install/configure to the following :  
  - Jenkins
  - NGINX
  - git
  - Azure CLI
  - Docker
  - a Jenkins job which builds a Dockerfile from a public git repository and pushes it to Azure Container Registry
