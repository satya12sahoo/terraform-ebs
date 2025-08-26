module "volumes" {
  source   = "../ebs"
  for_each = var.volumes

  name = try(each.value.name, null)
  tags = merge(var.default_tags, try(each.value.tags, {}))

  availability_zone    = each.value.availability_zone
  size                 = try(each.value.size, null)
  type                 = try(each.value.type, "gp3")
  iops                 = try(each.value.iops, null)
  throughput           = try(each.value.throughput, null)
  encrypted            = try(each.value.encrypted, true)
  kms_key_id           = try(each.value.kms_key_id, null)
  snapshot_id          = try(each.value.snapshot_id, null)
  multi_attach_enabled = try(each.value.multi_attach_enabled, false)
  outpost_arn          = try(each.value.outpost_arn, null)

  enable_attachment = try(each.value.enable_attachment, false)
  instance_id       = try(each.value.instance_id, null)
  device_name       = try(each.value.device_name, null)
  force_detach      = try(each.value.force_detach, false)
  skip_destroy      = try(each.value.skip_destroy, false)
}