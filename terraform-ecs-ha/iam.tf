resource "aws_iam_role" "ecs-instance" {
  name = "${var.service_name}-ecs-instance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "ecs-for-ec2" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


resource "aws_iam_role_policy_attachment" "ecs-instance-ecs-for-ec2" {
  role       = aws_iam_role.ecs-instance.name
  policy_arn = data.aws_iam_policy.ecs-for-ec2.arn
}

resource "aws_iam_instance_profile" "ecs-instance" {
  name = "${var.service_name}-ecs-instance"
  role = aws_iam_role.ecs-instance.name
}