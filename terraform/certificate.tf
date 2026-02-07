data "yandex_cm_certificate" "n8n-cert" {
  folder_id = var.yc_folder_id
  name      = "n8n"
}
