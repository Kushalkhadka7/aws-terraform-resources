locals {
  upper_name = upper(var.name)

  additional_tags = {
    "enviornment" = var.env
  }

  tags = merge(var.tags, local.additional_tags)
}


resource "aws_db_instance" "default_rds" {
  name                    = var.name
  engine                  = var.db_engine
  allocated_storage       = var.storage_size
  max_allocation_storage  = var.storage_max
  apply_immediately       = var.apply_immediately
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintainance_window     = var.maintainance_window
  username                = var.db_username
  password                = var.db_password
  engine_version          = var.engine_version

  tags = local.tags

  provisioner "local-exec" {
    command = "shackle db bootstrap"

    enviornment = {
      DB_INSTANCE = aws_db_instance.default_rds.identifier
    }
  }
}
