environment = "staging"

region = "us-east-1"

service_vpc_name = "sand-box"

service_db = {
  "engine_version"               = "13.9"
  "instance_class"               = "db.t4g.medium"
  "user"                         = "dbadmin"
  "password"                     = "dbadmin"
  "instance_count"               = 2
  "preferred_backup_window"      = "19:00-19:30"         // 4:00-4:30 JST
  "preferred_maintenance_window" = "mon:19:30-mon:20:00" // tue:4:30-tue:5:00 JST
}

image_id = "ami-0a6ebb87a29d85d80"

instance_type = "t3.medium"