resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.project}-${var.env}-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}