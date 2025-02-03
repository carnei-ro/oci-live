variable "compartment_id" {
  description = "The OCID of the tenancy containing the tag namespace."
  type        = string
}

variable "defined_tags" {
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {\"Operations.CostCenter\": \"42\"}"
  type        = map(string)
  default     = null
}

variable "description" {
  description = "The description you assign to the tag namespace during creation."
  type        = string
}

variable "freeform_tags" {
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {\"Department\": \"Finance\"}"
  type        = map(string)
  default     = null
}

variable "name" {
  description = "(Required) The name you assign to the tag namespace during creation. It must be unique across all tag namespaces in the tenancy and cannot be changed."
  type        = string
}

variable "is_retired" {
  description = "Whether the tag namespace is retired. For more information, see Retiring Key Definitions and Namespace Definitions."
  type        = bool
  default     = false
}
