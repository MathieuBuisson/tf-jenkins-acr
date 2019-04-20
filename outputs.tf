output "jenkins_vm_fqdn" {
  value = "${module.networking.public_ip_fqdn}"
}
