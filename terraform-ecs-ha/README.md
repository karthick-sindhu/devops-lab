# Devops-exercise

Create an AWS ECS cluster with autoscaling group for high availability

## Steps to reproduce

***Initialize terraform***
`terraform init`

***Run plan***
`terraform plan`

***Create the infrastructure***
`terraform apply`

Note: Replace your aws account_id in the following files before initialization
- ecs_service_alb.tf
- ecs_task_definition.tf