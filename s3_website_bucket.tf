resource "aws_s3_bucket" "hosting" {
  bucket = "hosting_bucket"
  acl    = "public_read"
  policy = file("hostingPolicy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"
  }


  cors_rule {
    alloallowed_headers = ["*"]
    allowed_methods     = ["PUT", "POST"]
    allowed_origins     = ["https://s3-website-test.hashicorp.com"]
    expose_headers      = ["ETag"]
    max_age_seconds     = 3000
  }

  logging {
    target_bucket = aws_s3_bucket.hosting_log_bucket.id
    target_prefix = "hosting-log/"
  }

  versioning {
    enabled = true
  }

  tags = {
    Name        = "hosting"
    Enviornment = "Prod"
  }
}


resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
  bucket = aws_s3_bucket.hosting.id

  policy = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "PublicReadForGetBucketObjects",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::${var.website_bucket_name}/*"
      }
    ]
  }
  EOF
}
