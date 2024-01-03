resource "aws_ecs_cluster" "cluster" {
  name = "${var.service_name}-ecs"
}