resource "aws_security_group" "ecs-instance" {
  name   = "${var.service_name}-ecs-instance"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.service_name}-ecs-instance"
  }
}

resource "aws_security_group_rule" "ecs-instance-ingress-alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs-instance.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ecs-instance-ingress-vpc" {
  type              = "ingress"
  from_port         = 49153
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.ecs-instance.id
  cidr_blocks       = [aws_vpc.main.cidr_block]
}

resource "aws_security_group_rule" "ecs-instance-egress-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ecs-instance.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "alb" {
  name   = "${var.service_name}-alb"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.service_name}-alb"
  }
}

resource "aws_security_group_rule" "alb-egress-all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.alb.id
  cidr_blocks       = ["0.0.0.0/0"]
}