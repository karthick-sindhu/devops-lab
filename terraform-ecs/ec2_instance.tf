resource "aws_instance" "instance" {
  ami                    = "ami-0e72545e0a1a5c759"
  instance_type          = "t3.small"
  iam_instance_profile   = "devops-lab-ecs-instance"
  subnet_id              = aws_subnet.public-a.arn
  vpc_security_group_ids = [aws_security_group.ecs-instance.id]

  user_data = <<EOS
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config
EOS

  tags = {
    Name = "devops-lab-ecs"
  }
}