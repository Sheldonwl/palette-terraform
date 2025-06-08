# This file is intentionally empty as we're using OpenStack RC file for authentication
variable "image_name" {
  type        = string
  description = "Name of the image to use for VM creation"
  default     = "edge-golden-image"
}

variable "flavor_name" {
  type        = string
  description = "Name of the flavor to use for VM creation"
  default     = "m1.medium"
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 10
}

variable "vm_network" {
  description = "Name of the network to use for VM creation"
  type        = string
  default     = "provider"
}
# The provider will automatically use the environment variables set by the RC file