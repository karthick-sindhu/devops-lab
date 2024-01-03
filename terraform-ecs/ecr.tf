resource "aws_ecr_repository" "test-app" {
  name         = "${var.service_name}-test-app"
  force_delete = true
}