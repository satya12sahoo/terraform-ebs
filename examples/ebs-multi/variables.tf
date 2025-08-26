variable "region" {
  type        = string
  description = "AWS region to use."
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags merged into each volume's tags."
  default     = {}
}

variable "volumes" {
  description = "Map of EBS volume configurations keyed by a logical name."
  type = map(object({
    availability_zone    = string
    name                 = optional(string)
    tags                 = optional(map(string))
    size                 = optional(number)
    type                 = optional(string, "gp3")
    iops                 = optional(number)
    throughput           = optional(number)
    encrypted            = optional(bool, true)
    kms_key_id           = optional(string)
    snapshot_id          = optional(string)
    multi_attach_enabled = optional(bool, false)
    outpost_arn          = optional(string)

    enable_attachment = optional(bool, false)
    instance_id       = optional(string)
    device_name       = optional(string)
    force_detach      = optional(bool, false)
    skip_destroy      = optional(bool, false)
  }))
}