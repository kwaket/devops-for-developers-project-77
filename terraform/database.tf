
resource "yandex_mdb_postgresql_cluster" "dbcluster" {
  name        = "n8n-dbcluster"
  environment = "PRESTABLE"
  network_id  = data.yandex_vpc_network.default.id

  config {
    version = 16
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 15
    }
    postgresql_config = {
      max_connections = 100
    }
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.n8n-subnet.id
  }

  depends_on = [yandex_vpc_subnet.n8n-subnet]
}

resource "yandex_mdb_postgresql_user" "dbuser" {
  cluster_id = yandex_mdb_postgresql_cluster.dbcluster.id
  name       = var.db_user
  password   = var.db_password
  depends_on = [yandex_mdb_postgresql_cluster.dbcluster]
}

resource "yandex_mdb_postgresql_database" "db" {
  cluster_id = yandex_mdb_postgresql_cluster.dbcluster.id
  name       = var.db_name
  owner      = yandex_mdb_postgresql_user.dbuser.name
  lc_collate = "en_US.UTF-8"
  lc_type    = "en_US.UTF-8"
  depends_on = [yandex_mdb_postgresql_cluster.dbcluster]
}

resource "local_file" "n8n" {
  content = templatefile("templates/db_credentials.yml.tpl", {
    db_url      = "${yandex_mdb_postgresql_cluster.dbcluster.host[0].fqdn}.rw.mdb.yandexcloud.net"
    db_name     = yandex_mdb_postgresql_database.db.name
    db_user     = yandex_mdb_postgresql_user.dbuser.name
    db_password = yandex_mdb_postgresql_user.dbuser.password
    db_port     = "6432"
  })
  filename = var.ansible_db_credentials_path
}
