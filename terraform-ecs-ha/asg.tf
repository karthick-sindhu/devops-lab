resource "aws_launch_template" "cluster" {
  name          = "${var.service_name}-cluster"
  image_id      = "ami-0e72545e0a1a5c759"
  instance_type = "t3.small"

  iam_instance_profile {
    name = "devops-lab-ecs-instance"
  }

  network_interfaces {
    security_groups = [aws_security_group.ecs-instance.id]
  }

  user_data = base64encode(<<EOS
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config
EOS
  )
}

resource "aws_autoscaling_group" "cluster" {
  name                = "${var.service_name}-cluster"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.public-a.id]

  launch_template {
    id      = aws_launch_template.cluster.id
    version = "$Latest"
  }
}