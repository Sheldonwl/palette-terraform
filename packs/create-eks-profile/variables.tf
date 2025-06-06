variable "sc_host" {
  description = "The SpectroCloud host URL"
  type        = string
}

variable "sc_api_key" {
  description = "API key for authenticating with SpectroCloud"
  type        = string
  sensitive   = true
}

variable "sc_project_name" {
  description = "Name of the SpectroCloud project"
  type        = string
}

