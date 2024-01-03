resource "aws_lb_target_group" "test-app" {
  name     = "${var.service_name}-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}