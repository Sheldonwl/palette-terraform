variable "ssh_public_key" {
  description = "SSH public key to add to the ubuntu user"
  type        = string
  default     = "" # Leave empty by default for security
  sensitive   = true
}

variable "ubuntu_password_hash" {
  description = "Password hash for the ubuntu user"
  type        = string
  default     = "" # Leave empty by default for security
  sensitive   = true
}

variable "github_username" {
  description = "GitHub username for ssh_import_id"
  type        = string
  default     = "" # Leave empty by default for security
}
