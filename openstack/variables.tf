# The provider will automatically use the environment variables set by the RC file

variable "vm_name_prefix" {
  description = "Prefix for VM names"
  type        = string
  default     = "edge-vm"
}

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
  default     = 3
}

variable "vm_network" {
  description = "Name of the network to use for VM creation"
  type        = string
  default     = "provider"
}

variable "key_pair_name" {
  description = "Name of the key pair to use for VM creation"
  type        = string
  default     = "random-key"
}

