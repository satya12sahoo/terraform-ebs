locals {
  name_tag = var.name == null || var.name == "" ? {} : { Name = var.name }
  merged_tags = merge(var.tags, local.name_tag)
}

resource "aws_ebs_volume" "this" {
  availability_zone    = var.availability_zone
  size                 = var.size
  type                 = var.type
  iops                 = var.iops
  throughput           = var.throughput
  encrypted            = var.encrypted
  kms_key_id           = var.kms_key_id
  snapshot_id          = var.snapshot_id
  multi_attach_enabled = var.multi_attach_enabled
  outpost_arn          = var.outpost_arn

  tags = local.merged_tags

  lifecycle {
    precondition {
      condition     = var.size != null || var.snapshot_id != null
      error_message = "Either set size or snapshot_id to create a volume."
    }
    precondition {
      condition     = !var.multi_attach_enabled || contains(["io1", "io2"], var.type)
      error_message = "multi_attach_enabled is only supported for io1/io2."
    }
    precondition {
      condition     = var.throughput == null || var.type == "gp3"
      error_message = "throughput is only valid for gp3."
    }
    precondition {
      condition     = var.iops != null || !contains(["io1", "io2"], var.type)
      error_message = "iops must be provided for io1 or io2."
    }
  }
}

resource "aws_volume_attachment" "this" {
  count       = var.enable_attachment ? 1 : 0
  device_name = var.device_name
  volume_id   = aws_ebs_volume.this.id
  instance_id = var.instance_id
  force_detach = var.force_detach
  skip_destroy = var.skip_destroy

  lifecycle {
    precondition {
      condition     = !var.enable_attachment || (var.instance_id != null && var.device_name != null)
      error_message = "When enable_attachment is true, instance_id and device_name must be set."
    }
  }
}