resource "aws_backup_vault" "this" {
  name = "${var.project}-${var.env}-vault"
}

resource "aws_backup_plan" "this" {
  name = "${var.project}-${var.env}-backup-plan"

  rule {
    rule_name         = "test-rule"
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 12 * * ? *)"
    lifecycle {
      delete_after = 7
    }
  }
}

# resource "aws_backup_selection" "this" {
#   iam_role_arn = "arn:aws:iam::123456789012:role/service-role/AWSBackupDefaultServiceRole"
#   name         = "${var.project}-${var.env}-backup-selection"
#   plan_id      = aws_backup_plan.this.id

#   resources = [
#     インスタンス等
#   ]
# }