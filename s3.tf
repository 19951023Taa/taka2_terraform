resource "aws_s3_bucket" "pd_backend" {
  bucket = "terraform.s3.tfstate"
}

# cloud trail --------------------------------------------------
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

resource "aws_s3_bucket_policy" "cloud_trail_bucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  policy = "${data.template_file.s3_cloudtrail.rendered}"
}
#----------------------------------------------------------


# config --------------------------------------------------
resource "aws_s3_bucket" "config_bucket" {
  bucket = "${var.project}-${var.env}-config-bucket"
}

resource "aws_s3_bucket_acl" "config_bucket_acl" {
  bucket = aws_s3_bucket.config_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "config_bucket_access" {
  bucket                  = aws_s3_bucket.config_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "config_bucket_policy" {
  bucket = aws_s3_bucket.config_bucket.id
  policy = "${data.template_file.s3_config.rendered}"
}
#----------------------------------------------------------