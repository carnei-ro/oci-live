variable "talos_version" {
  description = "The Talos version to use"
  type        = string
}

variable "talos_release_url" {
  description = "The Talos release URL to use. If not specified, this module will generate a Talos Factory URL. Check https://www.talos.dev/v1.9/talos-guides/install/cloud-platforms/oracle/."
  type        = string
  default     = null
}
