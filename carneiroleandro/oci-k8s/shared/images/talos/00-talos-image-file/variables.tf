variable "talos_version" {
  description = "The Talos version to use"
  type        = string
}

variable "talos_release_url" {
  description = "The Talos release URL to use. If not specified, this module will generate a GitHub Releases URL."
  type        = string
  default     = null
}
