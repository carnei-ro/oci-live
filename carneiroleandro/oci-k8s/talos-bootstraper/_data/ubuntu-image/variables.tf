variable "compartment_id" {
  description = "The OCID of the compartment."
  type        = string
}

variable "shape" {
  description = "The shape of the instance."
  type        = string
}

variable "operating_system" {
  description = "The operating system of the image."
  type        = string
}

variable "operating_system_version" {
  description = "The operating system version of the image."
  type        = string
}
