resource "aws_ecs_service" "test-app" {
  name            = "test-app"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.test-app.arn
  desired_count   = 1
}