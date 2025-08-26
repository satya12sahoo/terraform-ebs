output "volume_ids" {
  description = "Map of volume IDs keyed by input key."
  value       = { for k, m in module.volumes : k => m.volume_id }
}

output "arns" {
  description = "Map of volume ARNs keyed by input key."
  value       = { for k, m in module.volumes : k => m.arn }
}

output "availability_zones" {
  description = "Map of AZs keyed by input key."
  value       = { for k, m in module.volumes : k => m.availability_zone }
}

output "sizes" {
  description = "Map of sizes keyed by input key."
  value       = { for k, m in module.volumes : k => m.size }
}

output "types" {
  description = "Map of volume types keyed by input key."
  value       = { for k, m in module.volumes : k => m.type }
}

output "attachment_ids" {
  description = "Map of attachment IDs keyed by input key (may be null)."
  value       = { for k, m in module.volumes : k => m.attachment_id }
}