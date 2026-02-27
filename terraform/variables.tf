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

variable "datadog_api_key" {
  type        = string
  description = "Datadog API key"
}

variable "datadog_app_key" {
  type        = string
  description = "Datadog Application key"
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

variable "vm_image_family" {
  type        = string
  description = "Family of the VM image"
  default     = "debian-12"
}

variable "vm_user" {
  type        = string
  description = "Name of the VM user"
  default     = "debian"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key"
}

variable "ansible_inventory_path" {
  type        = string
  description = "Path to the Ansible inventory file"
  default     = "../ansible/inventory.yml"
}


variable "ansible_all_vault_path" {
  type        = string
  description = "Path to the Ansible vault file"
  default     = "../ansible/group_vars/all/vault_main.yml"
}

variable "ansible_n8n_vault_path" {
  type        = string
  description = "Path to the Ansible database credential file"
  default     = "../ansible/group_vars/n8n/vault_main.yml"
}

variable "ansible_n8n_vars_path" {
  type        = string
  description = "Path to the Ansible variables file"
  default     = "../ansible/group_vars/n8n/vars_main.yml"
}

variable "sg_n8n_port" {
  type        = number
  description = "Port for the n8n service"
  default     = 80
}
