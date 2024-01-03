resource "aws_lb" "lb" {
  name               = "devops-lab"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-instance.id]
  subnets            = [aws_subnet.public-a.id, aws_subnet.public-b.arn]
}

resource "aws_lb_listener" "test-app" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-app.arn
  }
}