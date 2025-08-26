variable "tags" {
  type        = map(string)
  description = "Tags to assign to the EBS volume."
  default     = {}
}

variable "availability_zone" {
  type        = string
  description = "AZ where the volume will be created (e.g., us-east-1a)."
}

variable "size" {
  type        = number
  description = "Size of the volume in GiB. If null, must set snapshot_id."
  default     = null
}

variable "type" {
  type        = string
  description = "EBS volume type (gp2, gp3, io1, io2, st1, sc1, standard)."
  default     = "gp3"

  validation {
    condition     = contains(["gp2", "gp3", "io1", "io2", "st1", "sc1", "standard"], var.type)
    error_message = "type must be one of: gp2, gp3, io1, io2, st1, sc1, standard."
  }
}

variable "iops" {
  type        = number
  description = "Provisioned IOPS. Required for io1/io2; optional for gp3."
  default     = null
}

variable "throughput" {
  type        = number
  description = "Throughput in MiB/s. Only valid for gp3."
  default     = null
}

variable "encrypted" {
  type        = bool
  description = "Whether to enable volume encryption."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ID/ARN for encryption. If null and encrypted is true, AWS default KMS key is used."
  default     = null
}

variable "snapshot_id" {
  type        = string
  description = "The snapshot ID from which to create the volume."
  default     = null
}

variable "multi_attach_enabled" {
  type        = bool
  description = "Enable Multi-Attach (only for io1/io2)."
  default     = false
}

variable "outpost_arn" {
  type        = string
  description = "ARN of the Outpost (if creating the volume on an Outpost)."
  default     = null
}

variable "enable_attachment" {
  type        = bool
  description = "If true, attach the created volume to an instance."
  default     = false
}

variable "instance_id" {
  type        = string
  description = "EC2 instance ID to attach the volume to (required if enable_attachment is true)."
  default     = null
}

variable "device_name" {
  type        = string
  description = "Device name for attachment (e.g., /dev/sdf). Required if enable_attachment is true."
  default     = null
}

variable "force_detach" {
  type        = bool
  description = "Forcibly detach the volume (use with caution)."
  default     = false
}

variable "skip_destroy" {
  type        = bool
  description = "Set to true to skip destroying the volume at destroy-time."
  default     = false
}