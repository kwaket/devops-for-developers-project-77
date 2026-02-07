variable "yc_iam_token" {
  type        = string
  description = "Yandex Cloud IAM token"
}

variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "yc_zone" {
  type        = string
  description = "Yandex Cloud Zone"
  default     = "ru-central1-a"
}

variable "db_user" {
  type        = string
  description = "Name of the n8n database user"
}

variable "db_password" {
  type        = string
  description = "Password for the n8n database user"
}

variable "db_name" {
  type        = string
  description = "Name of the n8n database"
}
