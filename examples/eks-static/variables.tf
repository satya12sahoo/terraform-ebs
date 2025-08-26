variable "region" {
  type        = string
  description = "AWS region to use."
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone for the EBS volume (e.g., us-east-1a)."
}

variable "name" {
  type        = string
  description = "Name tag for the volume."
}

variable "size" {
  type        = number
  description = "Size of the volume in GiB."
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}