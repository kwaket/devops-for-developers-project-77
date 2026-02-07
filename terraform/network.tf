data "yandex_vpc_network" "default" {
  name = "default"
}

resource "yandex_vpc_subnet" "n8n-subnet" {
  name           = "n8n-subnet-1"
  network_id     = data.yandex_vpc_network.default.id
  zone           = var.yc_zone
  v4_cidr_blocks = ["10.0.0.0/24"]
  folder_id      = var.yc_folder_id
}

resource "yandex_vpc_address" "n8n-static-ip" {
  name = "n8n-static-ip"

  external_ipv4_address {
    zone_id = var.yc_zone
  }
}
