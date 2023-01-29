# config role ---------------------------------------------
data "aws_iam_policy_document" "config_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
  }
}

# iam role
resource "aws_iam_role" "config_role" {
  name               = "${var.project}-${var.env}-config-role"
  description        = "config role"
  assume_role_policy = data.aws_iam_policy_document.config_assume_role.json
}

# AWS_ConfigRoleを作成したroleにアタッチ
resource "aws_iam_role_policy_attachment" "config-role-attachment" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

# 作成したroleにインラインポリシーを設定 ※S3にputする等の権限を付与
resource "aws_iam_role_policy" "config_policy" {
  name = "awsconfig-example"
  role = aws_iam_role.config_role.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.config_bucket.arn}",
        "${aws_s3_bucket.config_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}
# ---------------------------------------------------------

# backup role ---------------------------------------------
data "aws_iam_policy_document" "backup_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
}

# iam role
resource "aws_iam_role" "backup_role" {
  name               = "${var.project}-${var.env}-backup-role"
  description        = "backup role"
  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json
}

resource "aws_iam_role_policy_attachment" "backup_role_1" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "backup_role_2" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}