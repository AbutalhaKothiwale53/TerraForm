output "backup_plan_id" {
  description = "ID of the backup plan"
  value       = aws_backup_plan.backup_plan.id
}

output "backup_plan_arn" {
  description = "ARN of the backup plan"
  value       = aws_backup_plan.backup_plan.arn
}

output "backup_vault_name" {
  description = "Name of the backup vault"
  value       = aws_backup_vault.backup_vault.name
}

output "backup_vault_arn" {
  description = "ARN of the backup vault"
  value       = aws_backup_vault.backup_vault.arn
}

output "selection_id" {
  description = "ID of the backup selection"
  value       = aws_backup_selection.backup_selection.id
}
