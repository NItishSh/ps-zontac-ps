

resource "aws_instance" "public_server" {
  ami             = data.aws_ami.amazon_linux_2_ami.id
  instance_type   = var.web_server_size
  subnet_id       = aws_subnet.public_subnet.id
  key_name        = aws_key_pair.local_key.key_name
  security_groups = [aws_security_group.bastion.id, aws_security_group.ssh.id]
  tags = {
    "Name"  = "zantac_inc_web_server"
    "Owner" = "zantac_inc"
  }
  provisioner "file" {
    content     = file(var.public_key_path)
    destination = "/home/ec2-user/.ssh/id_rsa.pub"
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = var.ssh_user_name
      private_key = file(var.private_key_path)
      timeout     = var.ssh_time_out
    }
  }
  provisioner "file" {
    content     = file(var.private_key_path)
    destination = "/home/ec2-user/.ssh/id_rsa"
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = var.ssh_user_name
      private_key = file(var.private_key_path)
      timeout     = var.ssh_time_out
    }
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = var.ssh_user_name
      private_key = file(var.private_key_path)
      timeout     = var.ssh_time_out
    }
    inline = [
      "chmod 600 /home/ec2-user/.ssh/id_rsa",
      "chmod 644 /home/ec2-user/.ssh/id_rsa.pub"
    ]
  }
}

