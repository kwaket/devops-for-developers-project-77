resource "local_file" "ansible_inventory" {
  content = templatefile("./templates/inventory.yml.tpl", {
    web_1_ip = yandex_compute_instance.web-1.network_interface.0.nat_ip_address
    web_2_ip = yandex_compute_instance.web-2.network_interface.0.nat_ip_address
    vm_user  = var.vm_user
  })
  filename = var.ansible_inventory_path
}

resource "local_file" "ansible_vault" {
  content = templatefile("templates/app_vault.yml.tpl", {
    db_password = yandex_mdb_postgresql_user.dbuser.password
  })
  filename = var.ansible_vault_path
}


resource "local_file" "ansible_vars" {
  content = templatefile("templates/app_vars.yml.tpl", {
    db_host        = "${yandex_mdb_postgresql_cluster.dbcluster.host[0].fqdn}.rw.mdb.yandexcloud.net"
    db_name        = yandex_mdb_postgresql_database.db.name
    db_user        = yandex_mdb_postgresql_user.dbuser.name
    db_port        = "6432"
    app_port       = var.sg_n8n_port
    db_ssl_enabled = "true"
  })
  filename = var.ansible_vars_path
}
