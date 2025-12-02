data "aws_iam_role" "backup_role" {
  name = "AutomationBackupExecutionRole"
}

locals {
  resource_type_map = {
    "EC2" = "ec2"
    "EBS" = "ebs"
    "RDS" = "rds"
  }
  
  selected_resource_types = [
    for type in var.resource_types : local.resource_type_map[type]
  ]
}

resource "aws_backup_vault" "backup_vault" {
  name = "${var.project}-backup-vault-${var.environment}"

  tags = {
    Name = "${var.project}-backup-vault"
  }
}

resource "aws_backup_plan" "backup_plan" {
  name = var.backup_plan_name

  rule {
    rule_name             = "${var.project}-backup-rule"
    target_backup_vault   = aws_backup_vault.backup_vault.name
    schedule              = var.schedule_expression
    recovery_point_tags   = var.schedule_mode == "CRON" ? {} : null
    start_window          = var.schedule_mode == "RATE" ? 60 : null
    completion_window     = var.schedule_mode == "RATE" ? 120 : null

    lifecycle {
      delete_after = var.recovery_point_retention_days
    }
  }

  tags = {
    Name = var.backup_plan_name
  }
}

resource "aws_backup_selection" "backup_selection" {
  name             = "${var.project}-backup-selection-${var.environment}"
  plan_id          = aws_backup_plan.backup_plan.id
  iam_role_arn     = data.aws_iam_role.backup_role.arn
  type             = "RESOURCES"
  resources        = var.resource_ids

  selection_tag {
    type   = "CONDITION"
    key    = "Project"
    value  = var.project
  }

  depends_on = [aws_backup_plan.backup_plan]
}
