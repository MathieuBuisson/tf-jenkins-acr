{
    "commandToExecute": "./201-jenkins-acr.sh -jf \"${public_ip_fqdn}\" -u \"${admin_username}\" -g \"${git_repository}\" -r \"https://${registry_login_server}\" -ru \"${service_principal_id}\" -rp \"${service_principal_secret}\" -al \"https://raw.githubusercontent.com/Azure/azure-devops-utils/v0.30.0/\" -st \"\""
}
