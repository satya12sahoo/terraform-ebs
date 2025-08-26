output "volume_id" {
  description = "ID of the EBS volume."
  value       = aws_ebs_volume.this.id
}

output "arn" {
  description = "ARN of the EBS volume."
  value       = aws_ebs_volume.this.arn
}

output "availability_zone" {
  description = "Availability Zone of the volume."
  value       = aws_ebs_volume.this.availability_zone
}

output "size" {
  description = "Size of the volume."
  value       = aws_ebs_volume.this.size
}

output "type" {
  description = "Type of the volume."
  value       = aws_ebs_volume.this.type
}

output "iops" {
  description = "Provisioned IOPS."
  value       = aws_ebs_volume.this.iops
}

output "throughput" {
  description = "Provisioned throughput for gp3."
  value       = aws_ebs_volume.this.throughput
}

output "tags" {
  description = "All tags assigned to the volume."
  value       = aws_ebs_volume.this.tags
}

output "attachment_id" {
  description = "ID of the volume attachment if attached, else null."
  value       = try(aws_volume_attachment.this[0].id, null)
}