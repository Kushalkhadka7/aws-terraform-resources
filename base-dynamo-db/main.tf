resource "aws_dynamodb_table" "name" {
  name           = var.table_name
  billing_mode   = "PROVISIOED"
  read_capacity  = 1
  write_capcity  = 1
  hash_key       = var.hash_key
  range_key      = var.range_key
  stream_enabled = false



  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  attribute {
    name = var.range_key
    type = var.range_key_type
  }


  ttl {
    attribute_name = "evaluatedAt"
    enabled        = false
  }

  tags = {
    Name        = var.name
    Enviornment = var.env
  }

  replica {
    region_name = var.replica_region
  }
}
