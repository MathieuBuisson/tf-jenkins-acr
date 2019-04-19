# tf-jenkins-acr

## Overview

This is based on the following Azure ARM template from the **QuickStart Templates** repo :  
**[201-jenkins-acr](https://github.com/Azure/azure-quickstart-templates/tree/master/201-jenkins-acr)**  

It replicates the same functionality as this ~300 lines template, but in a much more concise, modular and flexible way.  

To that end, it splits this functionality into small, tightly focused units (i.e. **Terraform** modules) and then, it assembles them as a **Terraform** configuration (or root module).  
