resource "null_resource" "dev-hosts" {
  triggers = {
    template_rendered = "${data.template_file.ansible_inventory.rendered}"
  }
  provisioner "file" {
    connection {
      type        = "ssh"
      host        = aws_instance.public_server.public_ip
      user        = var.ssh_user_name
      private_key = file(var.private_key_path)
      timeout     = var.ssh_time_out
    }
    source      = "${path.module}/.ansible"
    destination = "/home/ec2-user/"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.public_server.public_ip
      user        = var.ssh_user_name
      private_key = file(var.private_key_path)
      timeout     = var.ssh_time_out
    }
    inline = [
      "sudo yum install python3 -y",
      "sudo amazon-linux-extras install ansible2 -y",
      "ansible-galaxy install geerlingguy.apache",
      "echo '${data.template_file.ansible_inventory.rendered}' > /home/ec2-user/.ansible/hosts"
    ]
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.public_server.public_ip
      user        = var.ssh_user_name
      private_key = file(var.private_key_path)
      timeout     = var.ssh_time_out
    }
    inline = [
      "ansible-playbook /home/ec2-user/.ansible/playbook-connectivity.yaml -i /home/ec2-user/.ansible/hosts",
    ]
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.public_server.public_ip
      user        = var.ssh_user_name
      private_key = file(var.private_key_path)
      timeout     = var.ssh_time_out
    }
    inline = [
      "ansible-playbook /home/ec2-user/.ansible/web-server.yaml -i /home/ec2-user/.ansible/hosts",
    ]
  }
}
