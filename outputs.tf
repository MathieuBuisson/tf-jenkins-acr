output "jenkins_url" {
  value = "http://${module.networking.public_ip_fqdn}"
}

output "ssh_connection_string" {
  value = "ssh -L 8080:localhost:8080 ${var.admin_username}@${module.networking.public_ip_fqdn}"
}

output "acr_login_server" {
  value = "${module.acr.login_server}"
}
