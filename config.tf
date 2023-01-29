# configを有効にするか
resource "aws_config_configuration_recorder_status" "awsconfig" {
  name       = aws_config_configuration_recorder.awsconfig.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.awsconfig]
}

# config本体の設定
resource "aws_config_configuration_recorder" "awsconfig" {
  name     = "${var.project}-${var.env}-config"
  role_arn = aws_iam_role.config_role.arn
  recording_group {
    all_supported                 = "true"
    include_global_resource_types = "true"
  }
}

# configの配信先[s3]の設定
resource "aws_config_delivery_channel" "awsconfig" {
  name           = "${var.project}-${var.env}-config-delivery"
  s3_bucket_name = aws_s3_bucket.config_bucket.bucket
  }