resource "aws_s3_bucket" "web_lb_logs" {
  bucket = "web_lb_logs"
}
resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]

  access_logs {
    bucket  = aws_s3_bucket.web_lb_logs.bucket
    prefix  = "web-lb"
    enabled = true
  }
}

resource "aws_lb_target_group" "webserver_asg" {
  name     = "webserver-asg-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.zantac_inc.id
}

resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver_asg.arn
  }
}
