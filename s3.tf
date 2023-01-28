resource "aws_s3_bucket" "pd_backend" {
  bucket = "terraform.s3.tfstate"
}


resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "${var.project}-${var.env}-cloudtrail-bucket"
}

resource "aws_s3_bucket_acl" "cloudtrail_bucket_acl" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "cloudtrail_bucket_access" {
  bucket                  = aws_s3_bucket.cloudtrail_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}