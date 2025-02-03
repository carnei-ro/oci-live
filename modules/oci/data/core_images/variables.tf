variable "compartment_id" {
  description = "The OCID of the compartment."
  type        = string
}

variable "display_name" {
  description = "A filter to return only resources that match the given display name exactly."
  type        = string
  default     = null
}

variable "operating_system" {
  description = "The image's operating system. Example: Oracle Linux"
  type        = string
  default     = null
}

variable "operating_system_version" {
  description = "The image's operating system version. Example: 7.2"
  type        = string
  default     = null
}

variable "shape" {
  description = "Shape name."
  type        = string
  default     = null
}

variable "state" {
  description = "A filter to only return resources that match the given lifecycle state. The state value is case-insensitive."
  type        = string
  default     = null
}

variable "sort_by" {
  description = "Sort the resources returned, by creation time or display name. Example TIMECREATED or DISPLAYNAME."
  type        = string
  default     = null
}

variable "sort_order" {
  description = "The sort order to use, either ascending (ASC) or descending (DESC)."
  type        = string
  default     = null
}
