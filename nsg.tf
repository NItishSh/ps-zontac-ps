resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Allow web inbound traffic from internet"
  vpc_id      = aws_vpc.zantac_inc.id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zantac_inc_web_nsg"
  }
}
resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.zantac_inc.id
  ingress {
    description     = "http"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zantac_inc_web_nsg"
  }
}
resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.zantac_inc.id

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.zantac_inc.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zantac_inc_ssh_nsg"
  }
}
resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.zantac_inc.id

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zantac_inc_bastion_nsg"
  }
}
