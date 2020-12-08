resource "aws_dax_cluster" "bar" {
  cluster_name       = var.cluster_name
  iam_role_arn       = data.aws_iam_role.example.arn
  node_type          = var.dax_node_type
  replication_factor = 1
  availability_zones = [data.aws_availability_zones.ids]
  description        = var.description
  security_group_ids = [aws_security_group.private.id]
  subnet_group_name  = [data.aws_subnets.private.name]
}
