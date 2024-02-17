resource "aws_instance" "web-app" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  tags = {
    Name = "web-app-instance"
  }
  user_data = <<EOF
    #!/bin/bash
    yum update -y

    ## Apache Setup
    yum install -y httpd
    chown -R apache:apache /var/www/html
    systemctl start httpd
    systemctl enable httpd

    EOF
}

resource "aws_security_group" "web-sg" {
  name        = "${var.region}-web-sg"
  description = "${var.region}-web-sg traffic"
  vpc_id      = data.aws_vpc.sandbox-tf-vpc.id
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
}