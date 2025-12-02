variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "AWS Account ID must be a 12-digit number."
  }
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "department" {
  description = "Department name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "created_date" {
  description = "Date when the resource was created (YYYY-MM-DD)"
  type        = string
}

variable "backup_plan_name" {
  description = "Name of the backup plan"
  type        = string
}

variable "recovery_point_retention_days" {
  description = "Number of days to retain recovery points"
  type        = number
  default     = 30
  validation {
    condition     = var.recovery_point_retention_days > 0
    error_message = "Recovery point retention days must be greater than 0."
  }
}

variable "schedule_mode" {
  description = "Backup schedule mode (RATE or CRON)"
  type        = string
  validation {
    condition     = contains(["RATE", "CRON"], var.schedule_mode)
    error_message = "Schedule mode must be RATE or CRON."
  }
}

variable "schedule_expression" {
  description = "Schedule expression (cron or rate)"
  type        = string
}

variable "resource_types" {
  description = "Types of resources to backup (EC2, EBS, RDS)"
  type        = list(string)
  validation {
    condition = alltrue([
      for type in var.resource_types : contains(["EC2", "EBS", "RDS"], type)
    ])
    error_message = "Resource types must be EC2, EBS, or RDS."
  }
}

variable "resource_ids" {
  description = "List of resource IDs to backup"
  type        = list(string)
  default     = []
}
