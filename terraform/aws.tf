provider "aws" {
  access_key = "${file(var.aws_access_key)}"
  secret_key = "${file(var.aws_secret_key)}"
  region     = "us-east-1"
}

data "aws_route53_zone" "selected" {
  name = "devops.rebrain.srwx.net."
}

resource "aws_route53_record" "web" {
  count      = "${length(var.instance_instance_name)}"
  zone_id    = "${data.aws_route53_zone.selected.zone_id}"
  name       = "${element(google_compute_instance.instance.*.name, count.index + 1)}.devops.rebrain.srwx.net"
  type       = "A"
  ttl        = "300"
  records    = ["${element(google_compute_address.instance_ip.*.address, count.index + 1)}"]
  depends_on = ["google_compute_instance.instance"]
}
