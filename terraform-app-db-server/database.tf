resource "aws_db_subnet_group" "db" {
  name        = "${var.region}-${var.service_name}"
  description = "${var.service_name} db subnet"
  subnet_ids  = data.aws_subnet.private.*.id
}

resource "aws_security_group" "db" {
  name        = "${var.service_name}-db-sg"
  description = "for ${var.service_name} db"
  vpc_id      = data.aws_vpc.sandbox-tf-vpc.id
  ingress {
    description     = "Allow DB traffic from only the web sg"
    from_port       = "5432"
    to_port         = "5432"
    protocol        = "tcp"
    security_groups = [aws_security_group.web-sg.id]
  }

  tags = {
    Name    = "${var.service_name}-db-sg"
    Country = var.region
  }
}


resource "aws_rds_cluster" "db" {
  cluster_identifier              = "${var.service_name}-${var.environment}-db"
  engine                          = "aurora-postgresql"
  engine_version                  = var.service_db["engine_version"]
  database_name                   = "migration"
  master_username                 = var.service_db["user"]
  master_password                 = var.service_db["password"]
  port                            = "5432"
  backup_retention_period         = "7"
  preferred_backup_window         = var.service_db["preferred_backup_window"]
  preferred_maintenance_window    = var.service_db["preferred_maintenance_window"]
  vpc_security_group_ids          = [aws_security_group.db.id]
  db_subnet_group_name            = aws_db_subnet_group.db.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db-13.name
  storage_encrypted               = true
  apply_immediately               = true
  skip_final_snapshot             = false
  final_snapshot_identifier       = "${var.service_name}-${var.environment}"

  tags = {
    Name = "${var.service_name}-${var.environment}"
  }
}

resource "aws_rds_cluster_instance" "db" {
  count                        = var.service_db["instance_count"]
  identifier                   = "${var.service_name}-${var.environment}-${format("%02d", count.index + 1)}"
  cluster_identifier           = aws_rds_cluster.db.id
  engine                       = "aurora-postgresql"
  engine_version               = var.service_db["engine_version"]
  instance_class               = var.service_db["instance_class"]
  db_subnet_group_name         = aws_db_subnet_group.db.name
  db_parameter_group_name      = aws_db_parameter_group.db-13.name
  publicly_accessible          = false
  apply_immediately            = true
  auto_minor_version_upgrade   = false
  preferred_maintenance_window = var.service_db["preferred_maintenance_window"]
  performance_insights_enabled = true

  tags = {
    Name = "${var.service_name}-${var.environment}-${format("%02d", count.index + 1)}"
  }
}

resource "aws_rds_cluster_parameter_group" "db-13" {
  name   = "${var.service_name}-rds-cluster-pg-13"
  family = "aurora-postgresql13"
}

resource "aws_db_parameter_group" "db-13" {
  name   = "${var.service_name}-rds-pg-13"
  family = "aurora-postgresql13"
}