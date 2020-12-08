module "admin-db" {
  source = "./base-db"

  name                    = "admin-db"
  db_engine               = "postgres"
  storage_size            = 20
  storage_max             = 100
  apply_immediately       = true
  backup_retention_period = 7
  backup_window           = "04:00-05:00"
  maintainance_window     = "Sun:05:00-Sun06:00"
  db_username             = "admin"
  db_password             = "admin"
  engine_version          = "10.2"
}
