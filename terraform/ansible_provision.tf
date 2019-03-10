resource "null_resource" "pre_playbook" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ../ansible/pre_playbook.yml"
  }

  depends_on = ["aws_route53_record.web"]
}

resource "null_resource" "playbook" {
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/hosts ../ansible/playbook.yml"
  }

  depends_on = ["aws_route53_record.web", "null_resource.pre_playbook"]
}
