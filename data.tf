data "aws_caller_identity" "self" {}

data "template_file" "s3_cloudtrail" {
  template = "${file("s3_bucketpolisy/s3_cloudtrail.json")}"

  vars = {
    bucket_arn = "${aws_s3_bucket.cloudtrail_bucket.arn}",
    account_id = "${data.aws_caller_identity.self.account_id}"
  }
}

