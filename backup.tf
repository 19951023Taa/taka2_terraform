resource "aws_backup_vault" "this" {
  name = "${var.project}-${var.env}-vault"
}

resource "aws_backup_plan" "this" {
  name = "${var.project}-${var.env}-backup-plan"

  rule {
    rule_name         = "test-rule"
    target_vault_name = aws_backup_vault.this.name
    # 日本時間深夜2時
    schedule = "cron(4 5 * * ? *)"
    lifecycle {
      delete_after = 7
    }
  }
}

resource "aws_backup_selection" "this" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "${var.project}-${var.env}-backup-selection"
  plan_id      = aws_backup_plan.this.id

  resources = ["arn:aws:ec2:ap-northeast-1:389759593235:instance/i-0e72619325586e30b"]
}