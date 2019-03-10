provider "google" {
  credentials = "${file("key.json")}"
  project     = "${var.instance_project}"
  region      = "${var.instance_region}"
}

resource "google_compute_instance" "instance" {
  count        = "${length(var.instance_instance_name)}"
  name         = "${var.instance_instance_name[count.index]}"
  machine_type = "${var.instance_machine_type}"
  project      = "${var.instance_project}"
  zone         = "${var.instance_zone}"
  tags         = ["http-server-kozlovpa"]

  metadata {
      "ssh-keys" = "${var.ssh_user}:${file(var.ssh_key_pub)}"
  }

  boot_disk {
    initialize_params {
      image = "${var.instance_disk_image}"
      size  = "${var.instance_disk_size}"
      type  = "${var.instance_disk_type}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${element(google_compute_address.instance_ip.*.address, count.index)}"
    }
  }
}

resource "google_compute_address" "instance_ip" {
  name  = "${var.instance_instance_name[count.index]}"
  count = "${length(var.instance_instance_name)}"
}

resource "google_compute_firewall" "default" {
  name    = "http-server-kozlovpa-rule"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http-server-kozlovpa"]
}

resource "google_compute_target_pool" "default" {
  name = "instance-pool"

  instances = ["${var.instance_zone}/${google_compute_instance.instance.0.name}",
                "${var.instance_zone}/${google_compute_instance.instance.1.name}"
  ]
}

resource "google_compute_forwarding_rule" "default" {
  name       = "website-forwarding-rule"
  target     = "${google_compute_target_pool.default.self_link}"
  port_range = "80"
}

output "default_pool_self_link" {
    description = "self_link for default target pool"
    value       = "${google_compute_target_pool.default.*.self_link}"
}