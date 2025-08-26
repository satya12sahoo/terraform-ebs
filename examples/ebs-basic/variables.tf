variable "region" {
  type        = string
  description = "AWS region to use."
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone for the EBS volume (e.g., us-east-1a)."
}

variable "tags" {
  type        = map(string)
  description = "Tags for the volume."
  default     = {}
}

variable "size" {
  type        = number
  description = "Size of the volume in GiB (ignored if snapshot_id set)."
  default     = null
}

variable "type" {
  type        = string
  description = "EBS volume type."
  default     = "gp3"
}

variable "iops" {
  type        = number
  description = "Provisioned IOPS."
  default     = null
}

variable "throughput" {
  type        = number
  description = "Throughput for gp3."
  default     = null
}

variable "encrypted" {
  type        = bool
  description = "Enable encryption."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ID/ARN."
  default     = null
}

variable "snapshot_id" {
  type        = string
  description = "Snapshot ID to create the volume from."
  default     = null
}

variable "multi_attach_enabled" {
  type        = bool
  description = "Enable Multi-Attach (io1/io2 only)."
  default     = false
}

variable "outpost_arn" {
  type        = string
  description = "Outpost ARN."
  default     = null
}

variable "enable_attachment" {
  type        = bool
  description = "Attach the volume to an instance."
  default     = false
}

variable "instance_id" {
  type        = string
  description = "Instance ID for attachment."
  default     = null
}

variable "device_name" {
  type        = string
  description = "Device name for attachment."
  default     = null
}

variable "force_detach" {
  type        = bool
  description = "Force detach."
  default     = false
}

variable "skip_destroy" {
  type        = bool
  description = "Skip destroy for the attachment."
  default     = false
}