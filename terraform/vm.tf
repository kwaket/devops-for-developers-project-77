
resource "yandex_iam_service_account" "web-sa" {
  folder_id = var.yc_folder_id
  name      = "web-instance-group-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.yc_folder_id
  role      = "editor" # TODO: fix it
  member    = "serviceAccount:${yandex_iam_service_account.web-sa.id}"
}

data "yandex_compute_image" "debian" {
  family = var.vm_image_family
}

locals {
  cloud_init = templatefile("${path.module}/templates/cloud-init.yml.tpl", {
    user           = var.vm_user
    ssh_public_key = "${file("${var.ssh_public_key_path}")}"
  })
}

resource "yandex_compute_instance" "web-1" {
  name               = "web-1"
  hostname           = "web-1"
  platform_id        = "standard-v3"
  zone               = var.yc_zone
  service_account_id = yandex_iam_service_account.web-sa.id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.n8n-subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.n8n-sg-vms.id]
  }

  metadata = {
    user-data = local.cloud_init
  }

  scheduling_policy {
    preemptible = true
  }

}

resource "yandex_compute_instance" "web-2" {
  name               = "web-2"
  hostname           = "web-2"
  platform_id        = "standard-v3"
  zone               = var.yc_zone
  service_account_id = yandex_iam_service_account.web-sa.id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.n8n-subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.n8n-sg-vms.id]
  }

  metadata = {
    user-data = local.cloud_init
  }

  scheduling_policy {
    preemptible = true
  }

}

resource "yandex_alb_target_group" "n8n-tg" {
  name = "n8n-tg"

  target {
    subnet_id  = yandex_vpc_subnet.n8n-subnet.id
    ip_address = yandex_compute_instance.web-1.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.n8n-subnet.id
    ip_address = yandex_compute_instance.web-2.network_interface.0.ip_address
  }
}
