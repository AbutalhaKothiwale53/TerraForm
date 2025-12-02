output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2.public_ip
  sensitive   = false
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.ec2.private_ip
}

output "instance_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.ec2.public_dns
}

output "root_volume_id" {
  description = "ID of the root volume"
  value       = aws_instance.ec2.root_block_device[0].volume_id
}
