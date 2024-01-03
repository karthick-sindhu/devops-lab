resource "aws_ecs_task_definition" "test-app" {
  family             = "devops-lab-test-app"
  execution_role_arn = "arn:aws:iam::<account_id>:role/ecsTaskExecutionRole"
  memory             = 256
  cpu                = 512

  container_definitions = jsonencode([
    {
      name   = "test-app"
      image  = "<account_id>.dkr.ecr.us-east-1.amazonaws.com/devops-lab-test-app:latest"
      memory = 256
      portMappings = [
        {
          containerPort = 8080
        }
      ]
    }
  ])
}