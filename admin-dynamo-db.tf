module "admin-dynamo-db" {
  source = "./base-dynamo-db"

  hash_key       = "userId"
  range_key      = "username"
  name           = "admin-dynamo-db"
  env            = "prod"
  replica_region = "us-east-1"
}
