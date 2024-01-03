resource "aws_ecs_service" "test-app-alb" {
  name            = "test-app-alb"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.test-app.arn
  iam_role        = "arn:aws:iam::<account_id>:role/ecsServiceRole"
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.test-app.arn
    container_name   = "test-app"
    container_port   = 8080
  }
}