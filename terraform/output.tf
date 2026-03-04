output "postgresql_host" {
  value = yandex_mdb_postgresql_cluster.dbcluster.host[0].fqdn
}

output "vm_1_ip" {
  description = "Private IP address of the VM_1 instance"
  value = yandex_compute_instance.web-1.network_interface.0.nat_ip_address
}

output "vm_2_ip" {
  description = "Private IP address of the VM_2 instance"
  value = yandex_compute_instance.web-1.network_interface.0.nat_ip_address
}
