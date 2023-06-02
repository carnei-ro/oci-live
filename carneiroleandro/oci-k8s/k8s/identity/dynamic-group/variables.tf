variable "compartment_id" {
  description = "The OCID of the tenancy containing the group."
  type        = string
}

variable "defined_tags" {
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags. Example: {\"Operations.CostCenter\": \"42\"}"
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. Example: {\"Department\": \"Finance\"}"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "The description you assign to the group during creation. Does not have to be unique, and it's changeable."
  type        = string
}

variable "matching_rule" {
  description = "The matching rule to dynamically match an instance certificate to this dynamic group. For rule syntax, see Managing Dynamic Groups."
  type        = string
}

variable "name" {
  description = "The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed."
  type        = string
}
