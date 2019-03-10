variable ssh_user {
  default = "appuser"
}
variable "ssh_key" {
  default = "~/.ssh/appuser"
}

variable "ssh_key_pub" {
  default = "~/.ssh/appuser.pub"
}

variable "aws_access_key" {
  description = "Path to access key"
  default     = "aws_access_key"
}

variable "aws_secret_key" {
  description = "Path to secret key"
  default     = "aws_secret_key"
}

variable instance_project {
  description = "Project where we create instance"
  default     = "rebrain"
}

variable instance_region {
  default = "europe-west1"
}

variable instance_zone {
  default = "europe-west1-b"
}

variable instance_instance_name {
  type    = "list"
  default = ["web1sovvvest", "web2sovvvest"]
}

variable instance_machine_type {
  description = "GCP machine type for reddit app instance"
  default     = "f1-micro"
}

variable instance_disk_image {
  description = "Disk image"
  default     = "ubuntu-1604-xenial-v20190306"
}

variable instance_disk_size {
  description = "Disk size"
  default     = "10"
}

variable instance_disk_type {
  description = "Disk type"
  default     = "pd-standard"
}
