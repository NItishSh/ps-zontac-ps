data "aws_ami" "amazon_linux_2_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_caller_identity" "current" {}
#https://www.linkbynet.com/produce-an-ansible-inventory-with-terraform
#https://stackoverflow.com/questions/23074412/how-to-set-host-key-checking-false-in-ansible-inventory-file
#https://github.com/geerlingguy/ansible-role-jenkins
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.tmpl")
  depends_on = [
    aws_instance.public_server,
  ]
  vars = {
    bastion-dns = aws_instance.public_server.public_dns,
    bastion-ip  = aws_instance.public_server.public_ip,
    bastion-id  = aws_instance.public_server.id,
    #TODO: ADD web server details to ansible inventory
    ssh_user_name = var.ssh_user_name
  }
}
