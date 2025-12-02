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

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  validation {
    condition = contains([
      "t2.nano", "t2.micro", "t2.small", "t3.small",
      "m5.large", "m5.xlarge", "c5.large", "c5.xlarge"
    ], var.instance_type)
    error_message = "Instance type must be a valid EC2 instance type."
  }
}

variable "ami_id" {
  description = "AMI ID to launch"
  type        = string
  validation {
    condition     = can(regex("^ami-[a-z0-9]{17}$", var.ami_id))
    error_message = "AMI ID must be valid (e.g., ami-12345678901234567)."
  }
}

variable "subnet_id" {
  description = "Subnet ID to launch instance in"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
  validation {
    condition     = var.root_volume_size > 0
    error_message = "Root volume size must be greater than 0."
  }
}

variable "root_volume_type" {
  description = "Type of the root volume (gp2, gp3, io1, st1)"
  type        = string
  default     = "gp2"
  validation {
    condition     = contains(["gp2", "gp3", "io1", "st1"], var.root_volume_type)
    error_message = "Root volume type must be gp2, gp3, io1, or st1."
  }
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = false
}

variable "project" {
  description = "Project name for tagging"
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

variable "department" {
  description = "Department name for tagging"
  type        = string
}

variable "created_date" {
  description = "Date when the resource was created (YYYY-MM-DD)"
  type        = string
}
