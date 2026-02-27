resource "local_file" "ansible_inventory" {
  content = templatefile("./templates/inventory.yml.tpl", {
    web_1_ip = yandex_compute_instance.web-1.network_interface.0.nat_ip_address
    web_2_ip = yandex_compute_instance.web-2.network_interface.0.nat_ip_address
    vm_user  = var.vm_user
    db_host  = yandex_mdb_postgresql_cluster.dbcluster.host[0].fqdn
  })
  filename = var.ansible_inventory_path
}
