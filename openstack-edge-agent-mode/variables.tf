# The provider will automatically use the environment variables set by the RC file

variable "vm_name_prefix" {
  description = "Name for the VM instance"
  type        = string
  default     = "ubuntu-instance"
}

variable "image_name" {
  type        = string
  description = "Name of the Ubuntu image to use for VM creation"
  default     = "ubuntu-22.04-kvm"
}

variable "flavor_name" {
  type        = string
  description = "Name of the flavor to use for VM creation"
  default     = "m1.medium"
}

variable "vm_network" {
  description = "Name of the network to use for VM creation"
  type        = string
  default     = "provider"
}

variable "key_pair_name" {
  description = "Name of the key pair to use for VM creation"
  type        = string
  default     = "maas-key"
}
