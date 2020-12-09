resource "aws_s3_bucket" "default" {
  bucket_name = var.bucket_name
  acl         = var.bucket_acl

  tags = {
    Name = "ec2-admin"
  }

  versioning {
    enabled = true
  }
}
