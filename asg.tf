resource "aws_key_pair" "local_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}
resource "aws_launch_configuration" "webserver_lc" {
  name_prefix     = "webserver-lc-"
  image_id        = data.aws_ami.amazon_linux_2_ami.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.local_key.key_name
  security_groups = [aws_security_group.web.id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "webserver_asg" {
  name                 = "webserver-asg"
  launch_configuration = aws_launch_configuration.webserver_lc.name
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = [aws_subnet.private_subnet.id]
  target_group_arns    = aws_lb_target_group.webserver_asg.arn
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}

