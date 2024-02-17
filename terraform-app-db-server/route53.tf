resource "aws_route53_zone" "sandbox-tf" {
  name = "${var.region}.sandbox-tf"

  vpc {
    vpc_id = data.aws_vpc.sandbox-tf-vpc.id
  }
}

resource "aws_route53_record" "web-app" {
  zone_id = aws_route53_zone.sandbox-tf.zone_id
  name    = "${var.region}.web-app.server"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web-app.public_ip]
}

output "hostname" {
  value = aws_route53_record.web-app.fqdn
}